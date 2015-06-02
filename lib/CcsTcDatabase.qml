import QtQuick 2.0
import Database 0.1
import "JsLib.js" as JsLib

Database {
    id: ccsTcDatabase

    signal loaded

    property var context

    property alias tcModel: listModel

    //Possible values for status: "loading", "error", "empty", "loaded"
    property string status: "loading"
    property alias rowCount: sqlTcData.count
    property double currentTime: -1
    property int currentIndex: 0

    connectionName: Date.now()

    SqlModel {
        id: sqlTcData
        async: true
        //query: "SELECT entryNo,id,name,completed,stageHistory,trx FROM "+ccsTcDatabase.databaseName+".tcidx
        //        WHERE (id,entryNo) in (SELECT id, MAX(entryNo) FROM tcidx GROUP BY id) ORDER BY trx DESC"
        query: "SELECT entryNo,id,name,completed,stageHistory,trx,lastUpdateTime FROM "+ccsTcDatabase.databaseName+".tcidx ORDER BY lastUpdateTime ASC"

        onUpdated: {
            console.log("TC: " + ccsTcDatabase.databaseName + " Count = " + count);
            if(count < 0) {
                ccsTcDatabase.status = "error";
                return;
            }

            if(count == 0) {
                ccsTcDatabase.status = "empty";
                return;
            }

            ccsTcDatabase.status = "loaded";
            ccsTcDatabase.loaded();
        }
    }

    ListModel {
        id: listModel
    }

    function reload() {
        if(ccsTcDatabase.status != "loading") {
            ccsTcDatabase.status = "loading";
            sqlTcData.reload();
        }
    }

    function seek(time) {
        if(time == currentTime)
            return;

        if(time < currentTime || currentTime < 0) {
            listModel.clear();
            sqlTcData.first();
            currentTime = -1;
            currentIndex = 0;
        }

        while(currentIndex < rowCount) {
            var row = sqlTcData.getCurrent();
            if(!row) break;

            var strUpdateTime = "" + row["lastUpdateTime"];
            var updateTime = Number(strUpdateTime.substr(0,strUpdateTime.length-6));
            row["lastUpdateTime"] = (new Date(updateTime)).toISOString().substr(11,5);
            //console.log("Last update time: " + row["lastUpdateTime"]);

            var strTrx = "" + row["trx"];
            var trx = Number(strTrx.substr(0,strTrx.length-6));
            row["trx"] = (new Date(trx)).toISOString().substr(11,5);
            //console.log("TRX: " + row["trx"]);

            if(updateTime > time) break;

            //Update
            var idx = findInListModel(listModel, "id", row["id"]);
            if(idx >= 0)
                listModel.set(idx, row);
            else
                listModel.insert(0,row);
            currentTime = updateTime;
            currentIndex++;
            sqlTcData.next();
        }
    }
    function findInListModel(list,key,value) {
        for(var i = 0; i < list.count; i++) {
            var row = list.get(i);
            if(row[key] == value)
                return i;
        }
        return -1;
    }

}
