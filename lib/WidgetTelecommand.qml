import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: container
    property var model
    width: 440
    height: 220
    border.width: 1
    border.color: "#009DCC"
    color: "#80000000"
    TableView {
        id: tableView
        anchors.fill: parent
        TableViewColumn {
            role: "trx"
            title: "Time"
            width: 55
        }
        TableViewColumn {
            role: "id"
            title: "ID"
            width: 95
        }
        TableViewColumn {
            role: "name"
            title: "Name"
            width: 140
        }
        TableViewColumn {
            role: "stageHistory"
            title: "Stage"
            width: 146
        }
        model: container.model
        style: StyleTableViewDark {
        }
    }
}
