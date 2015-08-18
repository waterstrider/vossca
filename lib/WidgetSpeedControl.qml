import QtQuick 2.3

Item {
    id: container
    property var param
    property double value: 1.0
    property alias border: widgetBorder.border

    width: 100
    height: 30

    WidgetButtonImage {
        id: buttonLeft
        anchors.left: container.left
        anchors.verticalCenter: container.verticalCenter
        height: 30
        width: 10
        imageSource: "images/WidgetSpeedControlLeft.png"
        imageSourcePressed: "images/WidgetSpeedControlLeftClear.png"
        onClicked: {
            if (value < 0.15)
                return
            else if (value <= 1)
                value = value - 0.1
            else if (value <= 10)
                value = value - 1
            else
                value = value - 10
        }
    }
    WidgetButtonImage {
        id: buttonRight
        anchors.right: container.right
        anchors.verticalCenter: container.verticalCenter
        height: 30
        width: 10
        imageSource: "images/WidgetSpeedControlRight.png"
        imageSourcePressed: "images/WidgetSpeedControlRightClear.png"
        onClicked: {
            if (value >= 100)
                return
            else if (value >= 10)
                value = value + 10
            else if (value >= 1)
                value = value + 1
            else
                value = value + 0.1
        }
    }

    Rectangle {
        id: widgetBorder
        color: "transparent"
        border.color: "white"
        border.width: 1
        radius: 2
        anchors.centerIn: parent
        width: 60
        height: 30

        WidgetLabelUI {
            id: widgetValue
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            text: "" + (value < 1 ? value.toFixed(1) : value.toFixed(0)) + "x"
        }
    }
}
