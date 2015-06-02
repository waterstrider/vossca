import QtQuick 2.0

Rectangle {
    signal clicked  
    property string label: ""
    property color bgColor: "transparent"
    property color borderColor: "#009DCC"
    property color textColor: "#FFFFFF"

    property string labelPressed: label
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

    property alias enabled: mouseArea.visible

    id: container

    width: 222; height: 43
    color: bgColor
    border.color: borderColor

    WidgetLabelUI {
        id: widgetLabel
        x: 0; y: 0
        anchors.fill: parent
        anchors.leftMargin: labelLeftMargin
        color: textColor
        text: label
    }

    onIsPressedChanged: {
        if(isPressed) {
            color = bgColorPressed;
            border.color = borderColorPressed;
            widgetLabel.color = textColorPressed;
            widgetLabel.text = labelPressed;
        } else {
            color = bgColor;
            border.color = borderColor;
            widgetLabel.color = textColor;
            widgetLabel.text = label;
        }
    }

    onIsOnChanged: isPressed = isOn
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: isPressed = !isOn
        onReleased: isPressed = isOn
        onCanceled: isPressed = isOn
        onClicked: {
            if(autoToggle) isOn= !isOn;
            container.clicked()
        }
    }
}
