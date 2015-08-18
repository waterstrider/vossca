import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    color: "transparent"
    width: 300
    height: 187
    id: container
    property string name
    property string imagePath
    Item {
        x: 15
        y: 22
        width: 109
        height: 109
        Image {
            id: bg
            source: "images/profile_mask.svg"
            sourceSize: Qt.size(parent.width, parent.height)
            opacity: 0.5
        }
        Image {
            id: profilePic
            sourceSize: Qt.size(parent.width, parent.height)
            source: imagePath
            smooth: true
            visible: false
        }
        Image {
            id: mask
            sourceSize: Qt.size(parent.width, parent.height)
            source: "images/profile_mask.svg"
            smooth: true
            visible: false
        }
        OpacityMask {
            anchors.fill: profilePic
            source: profilePic
            maskSource: mask
        }
    }
    WidgetLabelUI {
        x: 140
        y: 22
        text: "OPERATOR"
        font.family: "Avenir"
        font.pixelSize: 22
        color: "#009EDF"
        font.bold: true
    }
    WidgetLabelUI {
        x: 140
        y: 55
        width: 160
        wrapMode: Text.WordWrap
        text: name
        font.family: "Avenir"
        color: "#009EDF"
        font.pixelSize: 16
        font.bold: true
    }
    Item {
        id: line_container
        anchors.fill: parent
        WidgetLineWithInwardArrowsHorizontal {
            arrowLeftVisible: false
            length: 120
            x: 3
            y: 3
        }
        WidgetLineWithInwardArrowsVertical {
            arrowTopVisible: false
            length: 55
            x: 3
            y: 3
        }
        WidgetLineWithInwardArrowsHorizontal {
            length: 160
            x: 130
            y: 3
        }
        WidgetLineWithInwardArrowsHorizontal {
            length: 286
            x: 3
            y: 180
        }
    }
}
