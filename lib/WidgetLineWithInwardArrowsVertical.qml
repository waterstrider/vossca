
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
// This widget aims to create a vertical line with two arrows at both ends of the lines.
// The arrows are pointing inwards the line.
// /////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.0

Rectangle {
    property double length
    property bool arrowTopVisible: true
    property bool arrowBottomVisible: true

    width: 1
    height: length
    color: "transparent"
    Image {
        id: arrowTop

        source: "images/arrows/line_arrow_down.svg"
        sourceSize.width: parent.width * 3.18

        anchors.verticalCenter: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        visible: arrowTopVisible
    }

    WidgetLine {
        id: line

        width: parent.width
        height: parent.height - (arrowTop.height / 2)

        anchors.centerIn: parent.Center
    }

    Image {
        id: arrowBottom

        source: "images/arrows/line_arrow_up.svg"
        sourceSize.width: parent.width * 3.18

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: arrowBottomVisible
    }
}
