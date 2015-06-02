import QtQuick 2.0
import Database 0.1
import "JsLib.js" as JsLib
Database {
    id: ccsTmDatabase

    signal loaded

//    databaseName: "2014_10_27t10_36_31_administrator_csssrvnom_realtime"
//    type: "QMYSQL"
//    hostName: "localhost"
//    userName: "ccsuser"
//    password: "leiden1"

    property var context

    //Possible values for status: "loading", "error", "empty", "indexing", "loaded"
    property string status: "loading"
    property int currentIndex: 0
    property alias rowCount: sqlTmData.count
    property double startTime: -1
    property double endTime: -1
    property double progress: 0
    property var snapshots
    property var history

    connectionName: Date.now()

    SqlModel {
        id: sqlTmData
        async: true
        query: "SELECT name, rawValue, engValue, generationTime, rawValidity, engValidity, receivedTime  FROM "+ccsTmDatabase.databaseName+".tm_param_af WHERE (name IN (" + context.paramListString+ ")) AND (receivedTime>0) AND (generationTime>0) ORDER BY receivedTime"

        onUpdated: {
            console.log("TM: " + ccsTmDatabase.databaseName + " Count = " + count)

            if(count < 0) {
                ccsTmDatabase.status = "error";
                return;
            }

            if(count == 0) {
                ccsTmDatabase.status = "empty";
                return;
            }

            if(ccsTmDatabase.status != "loaded" || ccsTmDatabase.status != "indexing") {
                ccsTmDatabase.currentIndex = 0;

                // Find startTime and endTime
                sqlTmData.first();
                var row = sqlTmData.getCurrent();
                convertTime(row);
                ccsTmDatabase.startTime = row["receivedTime"];

                sqlTmData.last();
                row = sqlTmData.getCurrent();
                convertTime(row);
                ccsTmDatabase.endTime = row["receivedTime"];

                //Handle the case where endTime = startTime
                if(ccsTmDatabase.startTime >= ccsTmDatabase.endTime)
                    ccsTmDatabase.endTime = ccsTmDatabase.startTime + 1;

                // Start indexing
                ccsTmDatabase.status = "indexing"
                performIndexing.t = ccsTmDatabase.startTime
                performIndexing.running = true;
            }
        }
    }

    ProgressiveTask {
        id: performIndexing
        property var snapshots: []
        property var history: ({})
        property var result: ({})
        property double t: 0
        property int rowIndex: 0
        onExecute: {
            progress = rowIndex/ccsTmDatabase.rowCount;
            //console.log("Progress " + (100.0*progress).toFixed(0));

            if(rowIndex == 0)
                sqlTmData.first();

            if(rowIndex < ccsTmDatabase.rowCount) {
                var row, resultCopy;
                var counter = 10000;
                while(counter > 0 && rowIndex < ccsTmDatabase.rowCount) {
                    row = sqlTmData.getCurrent();
                    convertTime(row);

                    // Insert row in history
                    var pname = row["name"];
                    if(!(pname in history)) history[pname] = [];
                    history[pname].push(row);

                    // Update the running snapshot
                    if(row["receivedTime"] > t) {
                        resultCopy = JsLib.shallowCopy(result);
                        do {
                            snapshots.push(resultCopy);
                            t += context.snapshotInterval;
                        } while(row["receivedTime"] > t);
                    }
                    result[row["name"]] = row;
                    result["rowIndex"] = rowIndex;
                    rowIndex++;
                    sqlTmData.next();
                    counter--;
                }
            } else {
                running = false;

                //Push the final snapshot and save the snapshots
                snapshots.push(result);
                ccsTmDatabase.snapshots = snapshots;
                ccsTmDatabase.history = history;

                sqlTmData.first();
                ccsTmDatabase.status = "loaded";
                ccsTmDatabase.loaded();

                console.log("Database name = " + ccsTmDatabase.databaseName);
                console.log("Num of records read = " + rowIndex);
                console.log("Snapshot length = " + ccsTmDatabase.snapshots.length);
           }
        }
    }

    function getTmData(time) {
        if(ccsTmDatabase.status != "loaded") return null;

        var snapshotInterval = context.snapshotInterval;
        var snapshotIndex = Math.floor((time-ccsTmDatabase.startTime)/snapshotInterval);

        if(snapshotIndex>=ccsTmDatabase.snapshots.length)
            return null;

        var result = JsLib.shallowCopy(ccsTmDatabase.snapshots[snapshotIndex]);
        var rowIndex = result["rowIndex"];

        if(rowIndex >= ccsTmDatabase.rowCount-1) {
            ccsTmDatabase.currentIndex = ccsTmDatabase.rowCount;
            sqlTmData.seek(ccsTmDatabase.rowCount-1);
            return result;
        } else {
            rowIndex++;
            sqlTmData.seek(rowIndex);
            var row;
            do {
                row = sqlTmData.getCurrent();
                convertTime(row);
                if(row["receivedTime"] > time)
                    break;
                else
                    result[row["name"]] = row;
                rowIndex++;
            } while(sqlTmData.next());
            ccsTmDatabase.currentIndex = rowIndex;
            return result;
        }
    }

    function getTmHistory(paramName) {
        if(ccsTmDatabase.status != "loaded") return null;

        return history[paramName];
    }

    function peekNextTmPacket() {
        if(ccsTmDatabase.status != "loaded") return null;

        var row = sqlTmData.getCurrent();
        convertTime(row);
        return row;
    }

    function skipNextTmPacket() {
        var ret = sqlTmData.next();
        if(ret) ccsTmDatabase.currentIndex++;
        return ret
    }
    function convertTime(row) {
        var strGenTime = "" + row["generationTime"];
        var strRecTime = "" + row["receivedTime"];
        row["generationTime"] = Number(strGenTime.substr(0,strGenTime.length-6));
        row["receivedTime"] = Number(strRecTime.substr(0,strRecTime.length-6));
    }
}
