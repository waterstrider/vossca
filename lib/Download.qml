import QtQuick 2.0

Rectangle {
    signal commandDoubleClicked(string command)
    color: "transparent"
    Image {
        anchors.fill: parent
        id: bg
        source: "images/download_bg.svg"
    }
    WidgetLabelUI {
        text: "DOWNLOAD"
        color: "#3FA9F5"
        font.pixelSize: 14
        font.family: "Avenir"
        x: 8
        y: 8
    }
    WidgetButton {
        y: 40
        x: 8
        width: 115.666
        height: 40.666
        label: "PLAYBACK TM"
        fontSize: 14
        onClicked: commandDoubleClicked("PLAYBACK_TM")
    }
    WidgetButton {
        y: 40
        x: 138
        width: 190
        height: 40.666
        label: "SATELLITE EVENT"
        fontSize: 14
        onClicked: commandDoubleClicked("SATELLITE_EVENT")
    }
}
