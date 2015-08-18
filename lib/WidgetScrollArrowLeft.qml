
// /////////////////////////////////////////////////////////////////////////////////////////
// Widget Name: WidgetScrollArrowLeft
// /////////////////////////////////////////////////////////////////////////////////////////
// Historical revue:
// -----------------------------------------------------------------------------------------
// Version  |   Date        |   Author      |   Comments
//  v1.0    |   08/07/15    |   S. Chanate  |   Creation (Widget isn't design to be resizable yet)
// -----------------------------------------------------------------------------------------
// /////////////////////////////////////////////////////////////////////////////////////////
// Objective of the widget:
// This widget aims to create an arrow used for scrolling left.
// /////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: container

    property color glowColor: "#3FA9F5"
    property bool endOfScroll: false

    signal entered
    signal exited
    signal pressed
    signal released

    // Cannot scale yet...
    width: 17.25
    height: 35.75

    color: "transparent"

    Image {
        id: arrow

        source: "images/arrows/scroll_arrow_left.svg"
        sourceSize.height: parent.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: (endOfScroll == false) ? true : false
    }

    WidgetLine {
        id: midLine

        x: 12.5
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
    }

    WidgetLine {
        id: lastLine

        x: 17.25
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            arrowGlowEffect.visible = (endOfScroll == false) ? true : false
            midLineGlowEffect.visible = true
            lastLineGlowEffect.visible = true
            container.entered()
        }
        onExited: {
            arrowGlowEffect.visible = false
            midLineGlowEffect.visible = false
            lastLineGlowEffect.visible = false
            container.exited()
        }
        onPressed: {
            entered()
            container.pressed()
        }
        onReleased: {
            exited()
            container.released()
        }
    }

    Glow {
        id: arrowGlowEffect

        anchors.fill: arrow
        radius: 24
        spread: 0
        fast: true
        color: glowColor
        source: arrow
        visible: false
    }

    RectangularGlow {
        id: midLineGlowEffect

        anchors.fill: midLine
        glowRadius: 8
        color: glowColor
        visible: false
    }

    RectangularGlow {
        id: lastLineGlowEffect

        anchors.fill: lastLine
        glowRadius: 8
        color: glowColor
        visible: false
    }
}
