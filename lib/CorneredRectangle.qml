import QtQuick 2.3

Item {
    property double cornerSize: 0.1 * Math.min(width, height)
    property double borderWidth: 1.0
    property color borderColor: "#009DCC"
    property color color: "transparent"
    width: 100
    height: 62
    // *** Fill ***
    Rectangle {
        x: cornerSize
        y: 0
        width: parent.width - cornerSize
        height: parent.height
        color: parent.color
        visible: (parent.color != "transparent")
    }
    Rectangle {
        x: 0
        y: cornerSize
        width: cornerSize
        height: parent.height - cornerSize
        color: parent.color
        visible: (parent.color != "transparent")
    }
    Rectangle {
        x: 0
        y: cornerSize
        height: cornerSize * 1.4142136
        width: cornerSize * 1.4142136
        transformOrigin: Item.TopLeft
        rotation: -45
        color: parent.color
        visible: (parent.color != "transparent")
    }

    // *** Border ***
    Rectangle {
        width: borderWidth
        height: parent.height
        anchors.right: parent.right
        color: borderColor
    }

    Rectangle {
        height: borderWidth
        width: parent.width
        anchors.bottom: parent.bottom
        color: borderColor
    }

    Rectangle {
        width: borderWidth
        height: parent.height - cornerSize
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        color: borderColor
    }

    Rectangle {
        height: borderWidth
        width: parent.width - cornerSize
        anchors.top: parent.top
        anchors.right: parent.right
        color: borderColor
    }

    Rectangle {
        x: 0
        y: cornerSize
        height: borderWidth
        width: cornerSize * 1.4142136
        transformOrigin: Item.TopLeft
        rotation: -45
        color: borderColor
    }
}
