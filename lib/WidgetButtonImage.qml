import QtQuick 2.0

Rectangle {
    signal clicked
    property alias image: widgetImage

    property string label: ""
    property color bgColor: "transparent"
    property color borderColor: "transparent"
    property color textColor: "#FFFFFF"
    property string imageSource: ""

    property string labelPressed: label
    property color bgColorPressed: bgColor
    property color borderColorPressed: borderColor
    property color textColorPressed: textColor
    property string imageSourcePressed: imageSource

    property bool isPressed: isOn
    property bool isOn: false
    property bool autoToggle: false

    property int labelLeftMargin: 0
    property alias labelAlignment: widgetLabel.horizontalAlignment
    property alias fontFamily: widgetLabel.font.family
    property alias fontSize: widgetLabel.font.pixelSize
    property alias fontBold: widgetLabel.font.bold

    id: container

    width: 222; height: 43
    color: bgColor
    border.color: borderColor

    Image {
        id: widgetImage
        anchors.centerIn: parent
        source: imageSource
    }

    WidgetLabelUI {
        id: widgetLabel
        anchors.fill: parent
        anchors.leftMargin: labelLeftMargin
        horizontalAlignment: Text.AlignHCenter
        color: textColor
        text: label
    }

    onIsPressedChanged: {
        if(isPressed) {
            color = bgColorPressed;
            border.color = borderColorPressed;
            widgetImage.source = imageSourcePressed;
            widgetLabel.color = textColorPressed;
            widgetLabel.text = labelPressed;
        } else {
            color = bgColor;
            border.color = borderColor;
            widgetImage.source = imageSource;
            widgetLabel.color = textColor;
            widgetLabel.text = label;
        }
    }

    onIsOnChanged: isPressed = isOn
    MouseArea {
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
