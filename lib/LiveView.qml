import QtQuick 2.3

Rectangle {
    id: container
    property var context
    property var window
    property var current
    current: true
    width: 1920
    height: 1080
    color: "black"

    LiveTmModel {
        id: liveTmModel
        context: container.context
    }

    Rectangle {
        x: 63
        y: 5
        z: 1
        width: 100
        height: 18
        color: "black"
        border.color: "white"
        border.width: 1
        Text {
            anchors.fill: parent
            color: "white"
            text: "Ground Status"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        MouseArea {
            anchors.fill: parent
            //            onClicked: {
            //                screenGround.visible = true;
            //                screenSatellite.visible = false;
            //            }
            onClicked: {
                if (current) {
                    var comChildWindow = Qt.createComponent(
                                "NavigatorWindow.qml")
                    var win = comChildWindow.createObject()
                    var comView = Qt.createComponent("LiveView.qml")
                    win.stack.push({
                                       item: comView,
                                       properties: {
                                           context: container.context,
                                           window: win,
                                           current: false
                                       }
                                   })
                    if (rootView.fullScreen)
                        win.showFullScreen()
                    else
                        win.show()
                }
            }
        }
    }
    Rectangle {
        x: 183
        y: 5
        z: 1
        width: 100
        height: 18
        color: "black"
        border.color: "white"
        border.width: 1
        Text {
            anchors.fill: parent
            color: "white"
            text: "Satellite Status"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        MouseArea {
            anchors.fill: parent
            //            onClicked: {
            //                screenGround.visible = false;
            //                screenSatellite.visible = true;
            //            }
            onClicked: {
                //                if (!current) {

                //                }
                var comChildWindow = Qt.createComponent("NavigatorWindow.qml")
                var win = comChildWindow.createObject()
                var comView = Qt.createComponent("LiveView.qml")
                win.stack.push({
                                   item: comView,
                                   properties: {
                                       window: win,
                                       current: true
                                   }
                               })
                if (rootView.fullScreen)
                    win.showFullScreen()
                else
                    win.show()
            }
        }
    }
    ScreenTMGround {
        id: screenGround
        x: 0
        y: 0
        width: 1920
        height: 1080
        visible: !current
        window: container.window
        model: liveTmModel
    }
    ScreenTMSat2D {
        id: screenSatellite
        x: 0
        y: 0
        width: 1920
        height: 1080
        visible: current
        window: container.window
        model: liveTmModel
    }
}
