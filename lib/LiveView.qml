import QtQuick 2.0

Rectangle {
    id: container
    property var context
    property var window

    width: 1920; height: 1080
    color: "black"

    LiveTmModel {
        id: liveTmModel
        context: container.context
    }

    Rectangle {
        x: 63; y: 5; z: 1
        width: 100; height: 18
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
            onClicked: {
                screenGround.visible = true;
                screenSatellite.visible = false;
            }
        }
    }
    Rectangle {
        x: 183; y: 5; z: 1
        width: 100; height: 18
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
            onClicked: {
                screenGround.visible = false;
                screenSatellite.visible = true;
            }
        }
    }
    ScreenTMGround {
        id: screenGround
        x:0; y:0
        width: 1920; height: 1080
        visible: false
        window: container.window
        model: liveTmModel
    }
    ScreenTMSat2D {
        id: screenSatellite
        x: 0; y: 0
        width: 1920; height: 1080
        visible: true
        window: container.window
        model: liveTmModel
    }
}



