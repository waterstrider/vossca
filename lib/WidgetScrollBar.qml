import QtQuick 2.3

Item {
    id: scrollbar
    width: (handleSize + 2 * (backScrollbar.border.width + 1))
    visible: (flickable.visibleArea.heightRatio < 1.0)
    anchors {
        top: flickable.top
        right: flickable.right
        bottom: flickable.bottom
        margins: 1
        rightMargin: 7
    }

    property Flickable flickable: null
    property int handleSize: 6

    function scrollDown() {
        flickable.contentY = Math.min(
                    flickable.contentY + (flickable.height / 4),
                    flickable.contentHeight - flickable.height)
    }
    function scrollUp() {
        flickable.contentY = Math.max(
                    flickable.contentY - (flickable.height / 4), 0)
    }

    Binding {
        target: handle
        property: "y"
        value: (flickable.contentY * clicker.drag.maximumY
                / (flickable.contentHeight - flickable.height))
        when: (!clicker.drag.active)
    }
    Binding {
        target: flickable
        property: "contentY"
        value: (handle.y * (flickable.contentHeight - flickable.height) / clicker.drag.maximumY)
        when: (clicker.drag.active || clicker.pressed)
    }
    Rectangle {
        width: parent.width
        id: backScrollbar
        radius: 2
        antialiasing: true

        color: "#009EDF"
        opacity: 0.1
        border {
            color: "transparent"
        }
        anchors {
            fill: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {

            }
        }
    }
    Item {
        id: groove
        clip: true
        anchors {
            fill: parent
            topMargin: (backScrollbar.border.width + 1)
            leftMargin: (backScrollbar.border.width + 1)
            rightMargin: (backScrollbar.border.width + 1)
            bottomMargin: (backScrollbar.border.width + 1)
        }

        MouseArea {
            id: clicker
            drag {
                target: handle
                minimumY: 0
                maximumY: (groove.height - handle.height)
                axis: Drag.YAxis
            }
            anchors {
                fill: parent
            }
            onClicked: {
                flickable.contentY = (mouse.y / groove.height
                                      * (flickable.contentHeight - flickable.height))
            }
        }
        Item {
            id: handle
            height: Math.max(
                        20, (flickable.visibleArea.heightRatio * groove.height))
            anchors {
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: backHandle
                color: "#009EDF"
                opacity: (flickable.moving || clicker.pressed ? 1 : 0.3)
                anchors {
                    fill: parent
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }
            }
        }
    }
}
