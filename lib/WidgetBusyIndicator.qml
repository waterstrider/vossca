import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    id: container
    property alias running: busyIndicator.running
    property alias text: labelBusy.text
    anchors.fill: parent
    z: 80
    color: "#80000000"
    visible: running

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: false
    }

    WidgetLabelUI {
        id: labelBusy
        anchors.horizontalCenter: parent.horizontalCenter
        y: busyIndicator.y + busyIndicator.height + 20
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
        color: "#CCCCCC"
        text: "Loading ..."
        visible: text.length > 0
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
