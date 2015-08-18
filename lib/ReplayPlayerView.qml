import QtQuick 2.3
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: container

    property var context
    property var window
    property string sessionName
    property var date
    property var sessionList: context.getDbList(date.getFullYear(),
                                                date.getMonth(), date.getDate())

    Component.onCompleted: {
        console.log("ReplayPlayerView loaded")
        if (sessionName == null || sessionName == "") {
            if (sessionList.length > 0) {
                sessionName = sessionList[0].name
                updateInfoTable(sessionName)
                histTmModel.sessionName = sessionName
                histTmModel.reload()
            }
        } else {
            updateInfoTable(sessionName)
            histTmModel.sessionName = sessionName
            histTmModel.reload()
        }
    }

    Component.onDestruction: {
        console.log("ReplayPlayerView to be destructed")
    }

    function updateInfoTable(sName) {
        var sessionInfo = context.getDbInfo(sName)
        infoListModel.clear()
        infoListModel.append({
                                 property: "Date",
                                 value: sessionInfo.date.toISOString(
                                            ).substr(0, 10)
                             })
        infoListModel.append({
                                 property: "Time",
                                 value: sessionInfo.date.toISOString(
                                            ).substr(11, 5)
                             })
        infoListModel.append({
                                 property: "User",
                                 value: sessionInfo.user
                             })
        infoListModel.append({
                                 property: "Workstation",
                                 value: sessionInfo.workstation
                             })
        infoListModel.append({
                                 property: "Session type",
                                 value: sessionInfo.sessionType
                             })
    }

    HistTmModel {
        id: histTmModel
        context: container.context
    }

    width: 1920
    height: 1080
    color: "black"

    Image {
        id: imageBackground
        anchors.centerIn: parent
        source: "images/bg1.png"
    }

    WidgetLoginInfo {
        id: userInfo
        x: 10
        y: 90
        context: container.context
    }

    ComboBox {
        id: playList
        x: 10
        y: 320
        width: 300
        height: 30

        model: ListModel {
            id: sessionListModel
            Component.onCompleted: {
                var sessionList = context.getDbList(date.getFullYear(),
                                                    date.getMonth(),
                                                    date.getDate())
                for (var i = 0; i < sessionList.length; i++) {
                    var sessionInfo = sessionList[i]
                    sessionListModel.append({
                                                text: sessionInfo.date.toISOString(
                                                          ).substr(
                                                          11,
                                                          5) + " - " + sessionInfo.user + " - "
                                                      + sessionInfo.workstation,
                                                name: sessionInfo.name
                                            })
                    if (sessionInfo.name == sessionName) {
                        playList.currentIndex = i
                    }
                }
            }
        }
        onActivated: {
            sessionName = sessionListModel.get(index).name
            updateInfoTable(sessionName)
            histTmModel.sessionName = sessionName
            histTmModel.reload()
        }
    }

    ListModel {
        id: infoListModel
    }

    Rectangle {
        id: infoPanel
        x: 10
        y: 380
        width: 300
        height: 630
        border.width: 1
        border.color: "#009DCC"
        color: "#80000000"
        TableView {
            anchors.fill: parent
            TableViewColumn {
                role: "property"
                title: "Property"
                width: 99
            }
            TableViewColumn {
                role: "value"
                title: "Value"
                width: 199
            }
            model: infoListModel
            style: StyleTableViewDark {
            }
        }
    }

    TabView {
        id: tabView
        x: 335
        y: 90
        width: 1575
        height: 920
        style: TabViewStyle {
            tabOverlap: 0
            frameOverlap: 0
            tab: Rectangle {
                color: styleData.selected ? "#009DCC" : "transparent"
                border.color: "white"
                implicitWidth: 240
                implicitHeight: 36
                radius: 4
                WidgetLabelUI {
                    id: text
                    anchors.centerIn: parent
                    font.pixelSize: 20
                    text: styleData.title
                    color: "white"
                }
            }
            frame: Rectangle {
                color: "transparent"
                border.color: "white"
                border.width: 1
            }
        }

        WidgetBusyIndicator {
            id: busyIndicator
            running: (sessionName != null) && (sessionName != "")
                     && ((histTmModel.status == "loading"
                          || histTmModel.status == "indexing"))
            text: (histTmModel.status == "indexing") ? "Indexing ..." : "Loading ..."
        }

        //        Tab {
        //            title: "Activities"
        //        }
        Tab {
            title: "Satellite Status"
            ScreenTMSat2D {
                id: screenSatellite
                anchors.margins: 1
                anchors.fill: parent
                window: container.window
                model: histTmModel
                replayMode: true
                WidgetButtonImage {
                    z: 10
                    anchors.margins: 3
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: 16
                    height: 16
                    imageSource: "images/iconDetach.png"
                    onClicked: {
                        var comChildWindow = Qt.createComponent(
                                    "FullScreenWindow.qml")
                        var win = comChildWindow.createObject(container)
                        var comScreenTMSat2D = Qt.createComponent(
                                    "ScreenTMSat2D.qml")
                        comScreenTMSat2D.createObject(win.rootView, {
                                                          window: win,
                                                          model: histTmModel
                                                      })
                        win.show()
                    }
                }
            }
        }
        Tab {
            title: "Ground Status"
            ScreenTMGround {
                id: screenGround
                anchors.margins: 1
                anchors.fill: parent
                window: container.window
                model: histTmModel
                replayMode: true
                WidgetButtonImage {
                    z: 10
                    anchors.margins: 3
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: 16
                    height: 16
                    imageSource: "images/iconDetach.png"
                    onClicked: {
                        var comChildWindow = Qt.createComponent(
                                    "FullScreenWindow.qml")
                        var win = comChildWindow.createObject(container)
                        var comScreenTMGround = Qt.createComponent(
                                    "ScreenTMGround.qml")
                        comScreenTMGround.createObject(win.rootView, {
                                                           window: win,
                                                           model: histTmModel
                                                       })
                        win.show()
                    }
                }
            }
        }
    }

    Row {
        id: playbackController
        height: 70
        x: 30
        y: 1010
        spacing: 20
        WidgetButtonImage {
            id: buttonPlay
            width: 27
            height: 27
            anchors.verticalCenter: parent.verticalCenter
            imageSource: "images/buttonPlayClear.png"
            imageSourcePressed: "images/buttonPlay.png"
            isOn: histTmModel.status == "loaded" && !histTmModel.playing
            onClicked: if (isOn)
                           histTmModel.play()
        }
        WidgetButtonImage {
            id: buttonPause
            width: 27
            height: 27
            anchors.verticalCenter: parent.verticalCenter
            imageSource: "images/buttonPauseClear.png"
            imageSourcePressed: "images/buttonPause.png"
            isOn: histTmModel.status == "loaded" && histTmModel.playing
            onClicked: if (isOn)
                           histTmModel.pause()
        }
        WidgetButtonImage {
            id: buttonStop
            width: 27
            height: 27
            anchors.verticalCenter: parent.verticalCenter
            imageSource: "images/buttonStopClear.png"
            imageSourcePressed: "images/buttonStop.png"
            isOn: histTmModel.status == "loaded"
                  && (histTmModel.currentTime > histTmModel.startTime)
            onClicked: if (isOn)
                           histTmModel.stop()
        }
        WidgetPlaybackProgress {
            id: progressPlayback
            width: 1500
            anchors.verticalCenter: parent.verticalCenter
            startTime: histTmModel.startTime
            endTime: histTmModel.endTime
            currentTime: histTmModel.currentTime
            enabled: histTmModel.status == "loaded"
            onScrolledTo: histTmModel.scroll(time)
        }
        WidgetLabelUI {
            width: 70
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            text: "Speed"
        }
        WidgetSpeedControl {
            id: speedControl
            anchors.verticalCenter: parent.verticalCenter
            value: histTmModel.speed
            onValueChanged: histTmModel.speed = value
        }
    }
}
