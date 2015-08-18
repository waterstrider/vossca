import QtQuick 2.3

Item {
    id: container
    property var model
    property int selectedIndex
    property var selectedItem
    property color borderColor: "white"

    width: 100
    height: 30

    onModelChanged: model.countChanged.connect(updateSelection)
    onSelectedIndexChanged: updateSelection()

    function updateSelection() {
        if (selectedIndex >= 0 && selectedIndex < model.count) {
            var item = model.get(selectedIndex)
            if (item) {
                selectedItem = item.value
                widgetText.text = item.text
            }
        }
    }

    WidgetButtonImage {
        id: buttonLeft
        anchors.left: container.left
        anchors.verticalCenter: container.verticalCenter
        height: container.height / 1.5
        width: 0.2 * container.width
        imageSource: "images/WidgetSpeedControlLeft.png"
        imageSourcePressed: "images/WidgetSpeedControlLeftClear.png"
        onClicked: {
            if (selectedIndex > 0) {
                selectedIndex--
            }
        }
    }
    WidgetButtonImage {
        id: buttonRight
        anchors.right: container.right
        anchors.verticalCenter: container.verticalCenter
        height: container.height / 1.5
        width: 0.2 * container.width
        imageSource: "images/WidgetSpeedControlRight.png"
        imageSourcePressed: "images/WidgetSpeedControlRightClear.png"
        onClicked: {
            if (selectedIndex < model.count - 1) {
                selectedIndex++
            }
        }
    }

    Rectangle {
        id: widgetBorder
        color: "transparent"
        border.color: borderColor
        border.width: 1
        radius: 2
        anchors.centerIn: parent
        height: container.height
        width: 0.6 * container.width

        WidgetLabelUI {
            id: widgetText
            font.pixelSize: 0.5 * container.height
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
