import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    color: "transparent"
    width: 300
    height: 187
    id: container
    property bool showText: true
    property var date: new Date
    property int monthInc: container.date.getUTCMonth() + 1
    property int date_station_order
    property string source: "http://192.168.142.226/api/get_passes.json?year="
                            + container.date.getUTCFullYear(
                                ) + "&mon=" + container.monthInc + "&day="
                            + container.date.getUTCDate()
    Component.onCompleted: {
        console.log(source)
        var xhr = new XMLHttpRequest
        xhr.open("GET", source)
        xhr.onreadystatechange = function () {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var jsonString = xhr.responseText
                console.log(jsonString)
                var json = JSON.parse(jsonString)
                var passes = json.passes
                for (var i = 0; i < passes.length - 1; i++) {
                    console.log(Date.now() / 1000, passes[i].los,
                                passes[i + 1].los)
                    if (passes[i].los < Date.now() / 1000
                            && passes[i + 1].los > Date.now() / 1000) {
                        container.date_station_order = i + 1
                        inComingTestSeqModel.source = "http://192.168.142.226/api/get_pass_operations_in_date.json?date="
                                + container.date.getUTCFullYear(
                                    ) + "-" + container.monthInc + "-" + container.date.getUTCDate()
                        inComingTestSeqModel.query = "$.pass_operations["
                                + container.date_station_order + "].pass_operators[*]"
                        console.log(inComingTestSeqModel.query)
                    }
                    if (passes[0].los > Date.now() / 1000) {
                        container.date_station_order = 0
                        inComingTestSeqModel.source = "http://192.168.142.226/api/get_pass_operations_in_date.json?date="
                                + container.date.getUTCFullYear(
                                    ) + "-" + container.monthInc + "-" + container.date.getUTCDate()
                        inComingTestSeqModel.query = "$.pass_operations["
                                + container.date_station_order + "].pass_operators[*]"
                        console.log(inComingTestSeqModel.query)
                        break
                    }
                }
            }
        }
        xhr.send()
    }
    JSONListModel {
        id: inComingTestSeqModel
    }
    Column {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 18
        spacing: 4
        Repeater {
            model: inComingTestSeqModel.model
            Item {
                width: 45
                height: 45
                Image {
                    id: bg
                    source: "images/profile_mask.svg"
                    sourceSize: Qt.size(parent.width, parent.height)
                    opacity: 0.1
                }
                Image {
                    id: profilePic
                    sourceSize: Qt.size(parent.width, parent.height)
                    source: "http://192.168.142.226/" + photo
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
        }
    }
    Column {
        visible: container.showText
        anchors.left: parent.left
        anchors.leftMargin: 90
        anchors.top: parent.top
        anchors.topMargin: 15
        spacing: 4
        WidgetLabelUI {
            text: "OPERATOR"
            font.family: "Avenir"
            font.pixelSize: 22
            color: "#009EDF"
            font.bold: true
        }
        Repeater {
            model: inComingTestSeqModel.model
            WidgetLabelUI {
                width: 200
                wrapMode: Text.WordWrap
                text: index + 1 + ". " + full_name
                font.family: "Avenir"
                color: "#009EDF"
                font.pixelSize: 16
                font.bold: true
            }
        }
    }
    Item {
        id: line_container
        anchors.fill: parent
        WidgetLineWithInwardArrowsHorizontal {
            arrowLeftVisible: false
            length: 80
            x: 2
            y: 2
        }
        WidgetLineWithInwardArrowsVertical {
            arrowTopVisible: false
            length: 177
            x: 2
            y: 2
        }
        WidgetLineWithInwardArrowsHorizontal {
            arrowRightVisible: false
            length: 75
            x: 2
            y: 185
        }
        WidgetLineWithInwardArrowsVertical {
            arrowBottomVisible: false
            length: 62
            x: 75
            y: 125
        }
        WidgetLineWithInwardArrowsHorizontal {
            length: 213
            x: 85
            y: 2
        }
    }
}
