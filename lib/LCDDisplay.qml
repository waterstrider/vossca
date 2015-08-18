import QtQuick 2.0

Rectangle {
    id: display

    property int number: -1
    property color segmentColorD: "red"
    property color segmentOffColorD: "#333333"
    property real segmentWidthD: 3
    width: 45
    height: 40
    //    width: digit2.x + digit2.width + segmentWidthD
    //    height: digit1.y + digit1.height + segmentWidthD
    color: "transparent"
    Component.onCompleted: {
        width: width + segmentWidthD
        height: height + segmentWidthD
    }

    onNumberChanged: {
        digit2.number = number % 10
        digit1.number = Math.floor(number / 10)
    }

    LCDDigit {
        segmentColor: segmentColorD
        segmentOffColor: segmentOffColorD
        segmentWidth: segmentWidthD
        id: digit1
        x: segmentWidthD
        width: parent.width / 2 - segmentWidthD
        height: parent.height
    }

    LCDDigit {
        id: digit2
        width: parent.width / 2 - segmentWidthD
        height: parent.height
        segmentColor: segmentColorD
        segmentOffColor: segmentOffColorD
        segmentWidth: segmentWidthD
        anchors {
            left: digit1.right
            leftMargin: segmentWidthD
            top: digit1.top
        }
    }
}
