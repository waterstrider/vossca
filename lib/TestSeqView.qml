import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle {
    id: container
    property ListModel model
    color: "transparent"
    Image {
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        source: "images/command_list_bg.svg"
    }
    ListView {
        id: listView
        clip: true
        x: 4.8
        y: 20
        width: 308
        height: 530
        model: container.model
        spacing: 5
        delegate: Rectangle {
            width: 280
            height: 30
            color: "transparent"
            WidgetButtonItem {
                width: parent.width
                height: parent.height
                labelLeft: index + 1
                labelLeftMargin: 5
                borderColor: "#009DCC"
                bgColorPressed: "#009DCC"
                textColor: "#FFFFFF"
                label: ts_name
            }
            Image {
                x: parent.width - width - 5
                fillMode: Image.PreserveAspectFit
                height: parent.height
                source: ts_status == "OK" ? "images/lid_green.svg" : "images/lid_red.svg"
            }
        }
    }
    WidgetScrollBar {
        handleSize: 15
        flickable: listView
    }
}
