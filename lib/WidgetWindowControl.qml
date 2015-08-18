import QtQuick 2.3

Item {
    id: container
    signal minimize
    signal toggle
    signal close

    width: 103
    height: 20
    Row {
        anchors.fill: parent
        spacing: 0

        WidgetButtonImage {
            id: buttonMinimize
            width: 28
            height: 20
            imageSource: "images/WidgetWindowControlMinimize.png"
            imageSourcePressed: "images/WidgetWindowControlMinimizeActive.png"
            onClicked: minimize()
        }

        WidgetButtonImage {
            id: buttonToggle
            width: 28
            height: 20
            imageSource: "images/WidgetWindowControlToggle.png"
            imageSourcePressed: "images/WidgetWindowControlToggleActive.png"
            onClicked: toggle()
        }

        WidgetButtonImage {
            id: buttonClose
            width: 47
            height: 20
            imageSource: "images/WidgetWindowControlClose.png"
            imageSourcePressed: "images/WidgetWindowControlCloseActive.png"
            onClicked: close()
        }
    }
}
