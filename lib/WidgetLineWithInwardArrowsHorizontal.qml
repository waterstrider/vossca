
// /////////////////////////////////////////////////////////////////////////////////////////
// Widget Name: WidgetLineWithInwardArrowsHorizontal
// /////////////////////////////////////////////////////////////////////////////////////////
// Historical revue:
// -----------------------------------------------------------------------------------------
// Version  |   Date        |   Author      |   Comments
//  v1.0    |   07/07/15    |   S. Chanate  |   Creation
//  v1.1    |   08/07/15    |   S. Chanate  |   Rename file
//  v1.2    |   09/07/15    |   S. Chanate  |   Add ability to remove arrows
// -----------------------------------------------------------------------------------------
// /////////////////////////////////////////////////////////////////////////////////////////
// Objective of the widget:
// This widget aims to create a horizontal line with two arrows at both ends of the lines.
// The arrows are pointing inwards the line.
// /////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.0

Rectangle {
    property double length
    property bool arrowLeftVisible: true
    property bool arrowRightVisible: true

    width: length
    height: 1
    color: "transparent"
    Image {
        id: arrowLeft

        source: "images/arrows/line_arrow_right.svg"
        sourceSize.height: parent.height * 3.78

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: arrowLeftVisible
    }

    WidgetLine {
        id: line

        width: parent.width - (arrowLeft.width / 2)
        height: parent.height

        anchors.centerIn: parent.Center
    }

    Image {
        id: arrowRight

        source: "images/arrows/line_arrow_left.svg"
        sourceSize.height: parent.height * 3.78

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: arrowRightVisible
    }
}
