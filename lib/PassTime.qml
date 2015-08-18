import QtQuick 2.0
import QtQuick.Controls 1.3

Rectangle {
    function gettime(time) {
        return time.substring(11, 19)
    }
    function str_pad_left(string, pad, length) {
        return (new Array(length + 1).join(pad) + string).slice(-length)
    }
    function timeFormat(duration) {
        return "00:" + str_pad_left(Math.floor(duration / 60), '0',
                                    2) + ':' + str_pad_left(
                    Math.round(duration - (Math.floor(duration / 60) * 60)),
                    '0', 2)
    }
    function getUTCTime() {
        var str = (new Date()).toUTCString().split(" ")
        return str[3]
    }
    function getCurrentPass() {
        var i = 0
        var currentTime = getUTCTime()
        while (gettime(groupModel.model.get(i).los_iso) < currentTime) {
            i += 1
        }
        return gettime(groupModel.model.get(i).los_iso)
    }
    function removePastPass() {
        var cur = getCurrentPass()
        while (gettime(groupModel.model.get(0).los_iso) < cur
               && groupModel.model.count > 0) {
            groupModel.model.remove(0)
        }
    }

    color: "transparent"
    WidgetLabelUI {
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: "STATION & SATELLITE PASS TIME | DURATION"
        color: "#66CCFF"
        font.pixelSize: 16
        font.family: "Aniver"
    }

    JSONListModel {
        id: groupModel

        source: "http://192.168.142.226/api/get_passes.json"
        query: "$.passes[*]"
    }

    Rectangle {
        border.color: "#66CCFF"
        border.width: 1
        y: 30
        width: parent.width - 20
        height: 81
        anchors.bottom: parent.bottom
        color: "transparent"
        clip: true

        ListView {
            property string nextPass
            id: listView
            spacing: 8
            width: parent.width - 35
            height: 60
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            model: groupModel.model
            clip: true

            delegate: Rectangle {
                id: item
                Component.onCompleted: removePastPass()
                property bool isCurrentPass: {
                    if (getCurrentPass() == gettime(model.los_iso))
                        true
                    else
                        false
                }
                width: 431.336
                height: 23.14

                color: {
                    if (isCurrentPass)
                        "#7AC943"
                    else
                        "#29ABE2"
                }
                WidgetLabelUI {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    id: pass_text
                    text: model.station + " " + gettime(
                              model.aos_iso) + " TO " + gettime(
                              model.los_iso) + " | " + timeFormat(
                              model.duration)
                    color: {
                        if (isCurrentPass)
                            "#FFF200"
                        else
                            "white"
                    }
                    font.pixelSize: 14
                }
            }
        }
        Rectangle {
            width: 18
            height: 32
            anchors.right: parent.right
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -18
            color: "transparent"
            ColorAnimation on color {
                id: up_click
                running: false
                from: "transparent"
                to: "#393434"
                duration: 100
            }
            ColorAnimation on color {
                id: up_release
                running: false
                from: "#393434"
                to: "transparent"
                duration: 100
            }
            Image {
                width: 12
                height: 24
                anchors.centerIn: parent
                id: arrow_up
                source: "images/arrows/pass_time_arrow_up.svg"
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        up_click.start()
                    }
                    onReleased: {
                        up_release.start()
                    }
                    onClicked: {
                        // * * * Clickkkkkk!!
                        if (listView.currentIndex == (groupModel.model.count - 1))
                            listView.decrementCurrentIndex()
                        listView.decrementCurrentIndex()
                    }
                }
            }
        }
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 18
            color: "transparent"
            width: 18
            height: 32
            ColorAnimation on color {
                id: down_click
                running: false
                from: "transparent"
                to: "#393434"
                duration: 100
            }
            ColorAnimation on color {
                id: down_release
                running: false
                from: "#393434"
                to: "transparent"
                duration: 100
            }
            Image {
                width: 12
                height: 24
                anchors.centerIn: parent
                id: arrow_down
                source: "images/arrows/pass_time_arrow_down.svg"
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        down_click.start()
                    }
                    onReleased: {
                        down_release.start()
                    }
                    onClicked: {
                        // * * * Clickkkkkk!!
                        if (listView.currentIndex == 0)
                            listView.incrementCurrentIndex()
                        listView.incrementCurrentIndex()
                    }
                }
            }
        }
    }
}
