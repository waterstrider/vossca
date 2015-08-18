import QtQuick 2.0

Rectangle {
    id: container
    width: 205
    height: 80
    property string alarmDateTime
    color: "black"

    WidgetLabelUI {
        text: "COUNTDOWN"
        color: "#3FA9F5"
        font.pointSize: 16

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    WidgetCountdownTimer {
        alarmDateTime: container.alarmDateTime

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
