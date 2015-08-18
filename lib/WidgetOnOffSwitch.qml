
// /////////////////////////////////////////////////////////////////////////////////////////
// Widget Name: WidgetOnOffSwitch
// /////////////////////////////////////////////////////////////////////////////////////////
// Historical revue:
// -----------------------------------------------------------------------------------------
// Version  |   Date        |   Author      |   Comments
//  v1.0    |   15/07/15    |   S. Chanate  |   Creation (Widget isn't design to be resizable yet)
// -----------------------------------------------------------------------------------------
// /////////////////////////////////////////////////////////////////////////////////////////
// Objective of the widget:
// This widget aims to create an on/off switch that can be selected by clicked at the
// customize radio buttons.
// /////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.0

Rectangle {
    id: onOffSwitch

    color: "transparent"
    width: 140.333
    height: 89.453

    property bool currentState: false

    property color selectedColor: "#E06522"
    property color deselectedColor: "#95979A"

    property string selectedImg: "images/icons/radio_selected.svg"
    property string deselectedImg: "images/icons/radio_deselected.svg"

    Rectangle {
        id: offGroup

        color: "transparent"
        width: 56
        height: 89.453

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: offRadioButton

            sourceSize.width: 56
            source: deselectedImg

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

                onPressed: currentState = false
            }
        }

        WidgetLabelUI {
            id: offLabel

            text: "OFF"
            font.pixelSize: 20
            color: deselectedColor

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: onGroup

        color: "transparent"
        width: 56
        height: 89.453

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: onRadioButton

            sourceSize.width: 56
            source: deselectedImg

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

                onPressed: currentState = true
            }
        }

        WidgetLabelUI {
            id: onLabel

            text: "ON"
            font.pixelSize: 20
            color: deselectedColor

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    states: [
        State {
            name: "on"
            when: currentState

            PropertyChanges {
                target: onRadioButton
                source: selectedImg
            }
            PropertyChanges {
                target: onLabel
                color: selectedColor
            }

            PropertyChanges {
                target: offRadioButton
                source: deselectedImg
            }
            PropertyChanges {
                target: offLabel
                color: deselectedColor
            }
        },
        State {
            name: "off"
            when: !currentState

            PropertyChanges {
                target: offRadioButton
                source: selectedImg
            }
            PropertyChanges {
                target: offLabel
                color: selectedColor
            }

            PropertyChanges {
                target: onRadioButton
                source: deselectedImg
            }
            PropertyChanges {
                target: onLabel
                color: deselectedColor
            }
        }
    ]
}
