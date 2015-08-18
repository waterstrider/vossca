import QtQuick 2.0

Rectangle {
    color: "transparent"
    property string name
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 221.423
        height: 27.57
        color: "#6DCFF6"
        WidgetLabelUI {
            anchors.centerIn: parent
            id: passText
            text: "PASS NAME"
            color: "white"
        }
    }
    Rectangle {
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 293.709
        height: 62.57
        Image {
            id: bg
            anchors.fill: parent
            source: "images/pass_name_bg.svg"
        }
        y: 20
        WidgetLabelUI {
            anchors.centerIn: parent
            text: name
            color: "#009DCC"
            font.pixelSize: 24
        }
    }
}
