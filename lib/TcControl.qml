import QtQuick 2.0

Rectangle {
    id: container
    width: 140.333
    height: 132.808
    color: "transparent"
    property bool currentState: widgetOnOffSwitch.currentState
    onCurrentStateChanged: {
        widgetOnOffSwitch.currentState = container.currentState
    }

    WidgetLabelUI {
        text: "CONTROL TC"
        color: "#009EDF"
        font.pixelSize: 16

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    WidgetOnOffSwitch {
        id: widgetOnOffSwitch
        onCurrentStateChanged: container.currentState = widgetOnOffSwitch.currentState
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
