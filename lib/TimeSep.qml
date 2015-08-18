import QtQuick 2.0

Rectangle {
    id: container
    property color seperatorColor: "#7AC943"
    color: "transparent"
    width: 3
    height: 40

    Rectangle {
        color: container.seperatorColor
        x: 0
        y: 9
        width: 3
        height: 3
    }
    Rectangle {
        color: container.seperatorColor
        x: 0
        y: 27
        width: 3
        height: 3
    }
}
