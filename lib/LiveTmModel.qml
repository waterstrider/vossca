import QtQuick 2.3
import com.terma.TM 1.0
import com.terma.MIB 1.0

Item {
    id: liveTmModel
    property var context
    property var ccsTcDatabase
    property alias countdownModel: countdown
    property bool loaded: (tmListModel.count > 0)
    property double currentTime: Date.now()
    property var _tmParams: []

    Component.onCompleted: {
        console.log("LiveTmModel constructed")
        reload()
        tickTimer.start()
        tcTimer.start()
    }

    Component.onDestruction: {
        console.log("LiveTmModel to be destructed")
    }

    CountdownModel {
        id: countdown
        url: context.urlCountdown
    }

    function reload() {
        //Reload countdownModel
        //countdown.reload(currentTime,"THEOS","Sriracha");
        countdown.reload(currentTime, "THEOS", "SiRacha")

        //Load TC databases
        ccsTcDatabase = context.getCcsTcDatabase()
        if (ccsTcDatabase) {
            if (ccsTcDatabase.status == "loaded") {
                refreshTcData()
            } else {
                ccsTcDatabase.statusChanged.connect(refreshTcData)
            }
        } else {
            //status = "error";
            console.log("Error: TC database loading failed")
            return
        }
    }

    function getTcModel() {
        if (ccsTcDatabase)
            return ccsTcDatabase.tcModel
        else
            return null
    }

    function refreshTcData() {
        if (ccsTcDatabase.status == "loaded") {
            ccsTcDatabase.seek(currentTime)
        }
    }

    Timer {
        id: tickTimer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            // Update current time
            currentTime = Date.now()

            // Update countdown model
            countdown.update(currentTime)
        }
    }

    Timer {
        id: tcTimer
        interval: 3000
        running: false
        repeat: true
        onTriggered: {
            // Reload TC data
            if (ccsTcDatabase && (ccsTcDatabase.status == "loaded")) {
                ccsTcDatabase.reload()
                if (ccsTcDatabase.status == "loaded") {
                    refreshTcData()
                } else {
                    ccsTcDatabase.statusChanged.connect(refreshTcData)
                }
            }
        }
    }

    TmListModel {
        id: tmListModel
        table: "PCF"
        onCountChanged: {
            if (count > 0) {
                for (var paramName in _tmParams)
                    _tmParams[paramName].connect()
            }
        }
    }

    function param(paramName) {
        if (!(paramName in _tmParams)) {
            _tmParams[paramName] = comTmParam.createObject(liveTmModel, {
                                                               name: paramName
                                                           })
            if (tmListModel.count > 0)
                _tmParams[paramName].connect()
        }
        return _tmParams[paramName]
    }

    Component {
        id: comTmParam
        Item {
            id: tmItem
            property string name
            property string engValue: ""
            property string rawValue: ""
            property bool engValidity: false
            property bool rawValidity: false

            TmParam {
                id: tmParam
                onEngValueChanged: tmItem.engValue = engValue
                onRawValueChanged: tmItem.rawValue = rawValue
                onEngValidityChanged: tmItem.engValidity = engValidity
                onRawValidityChanged: tmItem.rawValidity = rawValidity
            }

            function connect() {
                tmParam.name = name
            }
        }
    }
}
