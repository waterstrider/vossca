import QtQuick 2.3

Item {
    signal clicked
    property string labelLeft: ""
    property string label: ""
    property color bgColor: "transparent"
    property color borderColor: "#009DCC"
    property color textColor: "#FFFFFF"

    property color bgColorPressed: "#009DCC"
    property color borderColorPressed: borderColor
    property color textColorPressed: textColor

    property bool isPressed: isOn
    property bool isOn: false
    property bool autoToggle: false

    property int labelLeftMargin: 10
    property int gap: 5
    property alias labelAlignment: widgetLabel.horizontalAlignment
    property alias fontFamily: widgetLabel.font.family
    property alias fontSize: widgetLabel.font.pixelSize
    property alias fontBold: widgetLabel.font.bold

    id: container

    width: 222
    height: 43

    CorneredRectangle {
        id: leftBox
        x: 0
        y: 0
        height: parent.height
        width: height
        borderColor: borderColor
        color: bgColor
        WidgetLabelUI {
            id: widgetLabelLeft
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            color: textColor
            text: labelLeft
        }
    }

    Rectangle {
        id: rightBox
        x: leftBox.width + gap
        y: 0
        height: parent.height
        width: parent.width - leftBox.width - gap
        border.color: borderColor
        color: bgColor
        WidgetLabelUI {
            id: widgetLabel
            anchors.fill: parent
            anchors.leftMargin: labelLeftMargin
            color: textColor
            text: label
        }
    }

    onIsPressedChanged: {
        if (isPressed) {
            leftBox.color = bgColorPressed
            rightBox.color = bgColorPressed
            leftBox.borderColor = borderColorPressed
            rightBox.border.color = borderColorPressed
            //widgetLabelLeft.color = "transparent"
            widgetLabelLeft.color = textColorPressed
            //widgetLabel.color = "transparent"
            widgetLabel.color = textColorPressed
        } else {
            leftBox.color = bgColor
            rightBox.color = bgColor
            leftBox.borderColor = borderColor
            rightBox.border.color = borderColor
            widgetLabelLeft.color = textColor
            widgetLabel.color = textColor
        }
    }

    onIsOnChanged: isPressed = isOn
    //    MouseArea {
    //        anchors.fill: parent
    //        onPressed: isPressed = !isOn
    //        onReleased: isPressed = isOn
    //        onCanceled: isPressed = isOn
    //        onClicked: {
    //            if (autoToggle)
    //                isOn = !isOn
    //            container.clicked()
    //        }
    //    }
}
