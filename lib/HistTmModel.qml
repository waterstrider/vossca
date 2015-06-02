import QtQuick 2.0
import Database 0.1
import "JsLib.js" as JsLib

Item {
    id: container
    property var context
    property string sessionName
    property double startTime: -1
    property double endTime: -1
    property double currentTime: -1
    property bool playing: false
    property double speed: 10.0

    property var ccsTmDatabase
    property var ccsTcDatabase
    property alias countdownModel: countdown
    property string status: "loading"
    property real progress: 0
    property var paramDict: ({})

    Component.onCompleted: {
        console.log("HistTmModel loaded");
        reload();
    }

    Component.onDestruction: {
        console.log("HistTmModel to be destructed")
    }

    CountdownModel {
        id: countdown
        url: context.urlCountdown
    }

    function reload() {
        if(sessionName !== null && typeof sessionName !== "undefined" && sessionName !== "") {
            playing = false;
            currentTime = -1;
            initializeParamDict();

            //Load TC databases
            ccsTcDatabase = context.getCcsTcDatabase(sessionName);
            if(ccsTcDatabase) {
                if(ccsTcDatabase.status == "loaded")
                    initializePlayer();
                else
                    ccsTcDatabase.statusChanged.connect(initializePlayer);
            } else {
                status = "error";
                console.log("Error: TC database loading failed");
                return;
            }


            //Load TM databases
            ccsTmDatabase = context.getCcsTmDatabase(sessionName);
            if(ccsTmDatabase ) {
                startTime = Qt.binding(function() { return ccsTmDatabase.startTime });
                endTime = Qt.binding(function() { return ccsTmDatabase.endTime });
                status = Qt.binding(function() { return ccsTmDatabase.status });
                progress = Qt.binding(function() { return ccsTmDatabase.progress });

                if(ccsTmDatabase.status == "loaded")
                    initializePlayer();
                else
                    ccsTmDatabase.statusChanged.connect(initializePlayer);
            } else {
                status = "error";
                console.log("Error: TM database loading failed");
                return;
            }
        }
    }

    function initializePlayer() {
        if(ccsTmDatabase.status == "loaded" && ccsTcDatabase.status == "loaded") {
            scroll(ccsTmDatabase.startTime);

            //Reload countdownModel
            countdown.reload(ccsTmDatabase.startTime, "THEOS");
        }
    }

    function initializeParamDict() {
        for(var i = 0; i < context.paramList.length; i++) {
            var paramName = context.paramList[i];
            if(!(paramName in paramDict)) {
                paramDict[paramName] = comTmParam.createObject(container, {"name": paramName});
            } else {
                var p = paramDict[paramName];
                p.engValue = "";
                p.rawValue = "";
                p.engValidity = false;
                p.rawValidity = false;
            }
        }
    }

    function param(paramName) {      
        if(!(paramName in paramDict)) {
            paramDict[paramName] = comTmParam.createObject(container, {"name": paramName});
        }
        return paramDict[paramName];
    }

    function paramHistory(paramName) {
        return ccsTmDatabase.getTmHistory(paramName);
    }

    Component {
        id: comTmParam
        Item {
            property string name
            property string engValue: ""
            property string rawValue: ""
            property bool engValidity: false
            property bool rawValidity: false
        }
    }

    function getTcModel() {
        if(ccsTcDatabase)
            return ccsTcDatabase.tcModel;
        else
            return null;
    }

    Timer {
        id: timer
        interval: 100
        running: false
        repeat: true
        onTriggered: {
            if(playing) {
                currentTime = Math.min(currentTime + (timer.interval*speed), container.endTime);
                //console.log(container.startTime + "," + currentTime + "," + container.endTime);

                // Update countdown model
                countdown.update(currentTime);

                // Update Tc model
                ccsTcDatabase.seek(currentTime);

                // Update Tm data
                while(true) {
                    var nextTmPacket = ccsTmDatabase.peekNextTmPacket();

                    if(!nextTmPacket) {
                        running = false;
                        break;
                    }

                    if(nextTmPacket["receivedTime"] > currentTime) break;
                    updateParamPacket(nextTmPacket);

                    if(!ccsTmDatabase.skipNextTmPacket()) {
                        running = false;
                        break;
                    }
                }
            }
        }
    }

    function play() {
         if(status=="loaded" && !playing) {
            if(currentTime < 0) {
                currentTime = container.startTime;
                var result = ccsTmDatabase.getTmData(currentTime);
                updateParams(result);
            }
            playing = true;
            timer.start();
        }
    }

    function scroll(newTime) {
        if(newTime >= container.startTime && newTime <= container.endTime) {
            if(playing) timer.stop();

            var result = ccsTmDatabase.getTmData(newTime);
            if(result != null) {
                currentTime = newTime;
                updateParams(result);
                ccsTcDatabase.seek(currentTime);
            }

            if(playing) timer.start();
        }
    }

    function pause() {
        timer.stop();
        playing = false;
    }

    function stop() {
        timer.stop();
        playing = false;
        scroll(container.startTime);
    }

    function updateParams(newParamData){
        for(var paramName in paramDict) {
            if(paramName in newParamData) {
                paramDict[paramName].rawValue = newParamData[paramName]["rawValue"];
                paramDict[paramName].engValue = newParamData[paramName]["engValue"];
                paramDict[paramName].rawValidity = newParamData[paramName]["rawValidity"];
                paramDict[paramName].engValidity = newParamData[paramName]["engValidity"];
            } else {
                paramDict[paramName].rawValue = "";
                paramDict[paramName].engValue = "";
                paramDict[paramName].rawValidity = false;
                paramDict[paramName].engValidity = false;
            }
        }
    }

    function updateParamPacket(paramPacket) {
        var paramName = paramPacket["name"];
        if(paramName in paramDict) {
            paramDict[paramName].rawValue = paramPacket["rawValue"];
            paramDict[paramName].engValue = paramPacket["engValue"];
            paramDict[paramName].rawValidity = paramPacket["rawValidity"];
            paramDict[paramName].engValidity = paramPacket["engValidity"];
        }
    }


}

