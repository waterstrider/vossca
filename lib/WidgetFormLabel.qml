import QtQuick 2.0

Rectangle {
    height: 17.319
    property string key
    property string value
    property real keyWidth
    Rectangle {
        x: 0
        y: 0
        width: keyWidth
        height: 17.319
        color: "#009CDD"
        WidgetLabelUI {
            id: keyLabel
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 8
            text: key
            font.pixelSize: 14
        }
    }
    WidgetLabelUI {
        id: valueLabel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: keyWidth + 12
        text: value
        font.pixelSize: 14
    }
}
