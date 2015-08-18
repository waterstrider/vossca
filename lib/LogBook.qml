import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Rectangle {
    color: "transparent"
    Image {
        id: bg
        source: "images/log_book_bg.svg"
    }

    WidgetLabelUI {
        x: 30
        y: 10
        id: title
        text: "LOG BOOK"
        font.family: "Arial"
        font.pixelSize: 18
        color: "#3FA9F5"
    }
    TableView {
        id: tableView
        clip: true
        y: 37

        anchors.left: parent.left
        anchors.leftMargin: 10
        width: parent.width - 40
        height: parent.height - 47
        TableViewColumn {
            role: "type"
            title: "TYPE"
            width: 100
        }
        TableViewColumn {
            role: "time"
            title: "TIME"
            width: 200
        }
        TableViewColumn {
            role: "message"
            title: "MESSAGE"
            width: 300
        }

        model: LogList.logModel

        style: StyleTableViewDark {
        }
    }
}
