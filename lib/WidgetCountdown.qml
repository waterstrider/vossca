import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: container
    property var model
    width: 497; height: 152
    border.width: 1
    border.color: "#009DCC"
    color: "#80000000"
    TableView {
        id: tableView
        anchors.fill: parent
        TableViewColumn {role: "sat"; title: "Sat"; width: 70}
        TableViewColumn {role: "station"; title: "Station"; width: 70}
        TableViewColumn {role: "aos"; title: "AOS"; width: 115}
        TableViewColumn {role: "los"; title: "LOS"; width: 80}
        TableViewColumn {role: "duration"; title: "Dur"; width: 57}
        TableViewColumn {role: "count"; title: "Count"; width: 82}
        model: container.model
        style: StyleTableViewDark { }
    }
}


