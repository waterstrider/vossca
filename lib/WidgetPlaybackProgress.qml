import QtQuick 2.3

Item {
    signal scrolledTo(var time)
    property bool enabled: false
    property double currentTime: 0.0
    property double startTime: 0.0
    property double endTime: 100
    property color color

    height: 50

    WidgetLabelUI {
        id: labelStartTime
        anchors.left: parent.left
        y: 15
        width: 100
        horizontalAlignment: Text.AlignHCenter
        text: (enabled && startTime > 0) ? (new Date(startTime)).toISOString(
                                               ).substr(11, 8) : "--:--:--"
    }

    WidgetLabelUI {
        id: labelEndTime
        anchors.right: parent.right
        y: 15
        width: 100
        horizontalAlignment: Text.AlignHCenter
        text: (enabled && endTime > 0) ? (new Date(endTime)).toISOString(
                                             ).substr(11, 8) : "--:--:--"
    }

    Item {
        id: bar
        x: 100
        y: 7
        height: 20
        width: parent.width - 200

        Rectangle {
            height: 2
            width: parent.width
            anchors.bottom: parent.bottom
            border.color: color
        }

        Image {
            id: imageMarker
            source: "images/WidgetPlaybackProgress.png"
            y: 5
            x: -width / 2 + bar.width * Math.min(
                   1.0,
                   Math.max(0.0,
                            (currentTime - startTime) / (endTime - startTime)))
            WidgetLabelUI {
                id: labelCurrentTime
                x: -width / 2 + 5
                y: -20
                horizontalAlignment: Text.AlignHCenter
                text: ((currentTime > startTime)
                       && (currentTime < endTime)) ? (new Date(currentTime)).toISOString(
                                                         ).substr(11, 8) : ""
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (enabled) {
                    var newTime = startTime + (mouseX / width) * (endTime - startTime)
                    scrolledTo(newTime)
                    console.log("Clicked at " + mouseX + " Time = " + newTime)
                }
            }
            onPositionChanged: {
                if (enabled && (mouse.buttons & Qt.LeftButton)) {
                    var newTime = startTime + (mouseX / width) * (endTime - startTime)
                    console.log("Position changed to " + mouseX + " Time = " + newTime)
                    scrolledTo(newTime)
                }
            }
        }
    }
}
