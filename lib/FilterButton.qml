import QtQuick 2.0

Rectangle {
    id: filterButton

    property string text
    property bool sub: false
    signal selected

    color: {
        if (sub)
            "#276991"
        else
            "transparent"
    }
    border.color: "#3FA9F5"
    border.width: 1
    width: 100
    height: 30

    state: "normal"
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: filterButton
                color: {
                    if (sub)
                        "#276991"
                    else
                        "transparent"
                }
            }
        },
        State {
            name: "selected"
            PropertyChanges {
                target: filterButton
                color: "#3FA9F5"
            }
        }
    ]
    transitions: [
        Transition {
            from: "notmal"
            to: "selected"
            ColorAnimation {
                target: filterButton
                duration: 100
            }
        },
        Transition {
            from: "selected"
            to: "normal"
            ColorAnimation {
                target: filterButton
                duration: 100
            }
        }
    ]
    Text {
        anchors.centerIn: parent
        text: filterButton.text
        color: "white"
        font.pixelSize: 11
        font.family: "Avenir"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            selected()
        }
    }
}
