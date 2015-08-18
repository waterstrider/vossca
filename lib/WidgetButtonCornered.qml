import QtQuick 2.3

Item {
    signal clicked
    property string label: ""
    property color bgColor: "transparent"
    property color borderColor: "#009DCC"
    property color textColor: "#FFFFFF"

    property string labelPressed: ""
    property color bgColorPressed: "#009DCC"
    property color borderColorPressed: borderColor
    property color textColorPressed: textColor

    property bool isPressed: isOn
    property bool isOn: false
    property bool autoToggle: false

    property int labelLeftMargin: 10
    property alias labelAlignment: widgetLabel.horizontalAlignment
    property alias fontFamily: widgetLabel.font.family
    property alias fontSize: widgetLabel.font.pixelSize
    property alias fontBold: widgetLabel.font.bold

    id: container

    width: 222
    height: 43

    CorneredRectangle {
        id: box
        x: 0
        y: 0
        height: parent.height
        width: parent.width
        borderColor: borderColor
        color: bgColor
        WidgetLabelUI {
            id: widgetLabel
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            color: textColor
            text: label
        }
    }

    onIsPressedChanged: {
        if (isPressed) {
            box.color = bgColorPressed
            box.borderColor = borderColorPressed
            widgetLabel.color = textColorPressed
            widgetLabel.text = labelPressed
        } else {
            box.color = bgColor
            box.borderColor = borderColor
            widgetLabel.color = textColor
            widgetLabel.text = label
        }
    }

    onIsOnChanged: isPressed = isOn
    MouseArea {
        anchors.fill: parent
        onPressed: isPressed = !isOn
        onReleased: isPressed = isOn
        onCanceled: isPressed = isOn
        onClicked: {
            if (autoToggle)
                isOn = !isOn
            container.clicked()
        }
    }
}
