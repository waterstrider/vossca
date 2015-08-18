import QtQuick 2.3

Item {
    signal dayClicked(var clickedDate)
    signal itemClicked(var clickedDate, var clickedItem)

    property int month
    property int year
    property var model

    id: container

    Row {
        spacing: 5
        Repeater {
            model: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
            WidgetLabelUI {
                width: 200
                height: 20
                horizontalAlignment: Text.AlignRight
                color: (index == 0) ? "red" : "white"
                text: modelData
            }
        }
    }

    Grid {
        x: 0
        y: 20
        columns: 7
        rowSpacing: 12
        columnSpacing: 5
        Repeater {
            model: 35
            WidgetButtonCornered {
                property var date: getDateForCalMonth(year, month, index)
                width: 200
                height: 160
                WidgetLabelUI {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 5
                    anchors.topMargin: 5
                    text: date.getDate()
                    color: (date.getMonth() == month) ? "white" : "gray"
                }
                Flickable {
                    x: 0
                    y: 25
                    width: 200
                    height: Math.min(130, col.height)
                    clip: true
                    flickableDirection: Flickable.VerticalFlick
                    contentWidth: 200
                    contentHeight: col.height
                    JSONListModel {
                        id: passModel
                        property int monthInc: date.getUTCMonth() + 1
                        source: "http://192.168.142.226/api/get_passes.json?year="
                                + date.getUTCFullYear(
                                    ) + "&mon=" + monthInc + "&day=" + date.getUTCDate()
                        query: "$.passes[*]"
                    }

                    Column {
                        id: col
                        spacing: 2
                        Repeater {
                            model: passModel.model
                            WidgetButton {
                                x: 10
                                width: 180
                                height: 16
                                fontSize: 14
                                labelLeftMargin: 5
                                borderColor: "transparent"
                                //                                label: modelData["date"].toISOString().substr(
                                //                                           11,
                                //                                           5) + " - " + modelData["user"].substr(
                                //                                           0,
                                //                                           10) + " - " + modelData["workstation"].substr(
                                //                                           0, 6)
                                label: name
                                onClicked: itemClicked(date, name)
                            }
                        }
                    }
                }
                onClicked: {
                    dayClicked(date)
                }
            }
        }
    }

    function getDateForCalMonth(year, month, i) {
        var d = new Date(year, month, 1)
        d.setDate(d.getDate() - d.getDay() + i)
        return d
    }
}
