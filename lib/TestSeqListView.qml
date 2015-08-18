import QtQuick 2.3

Rectangle {
    property var window
    property var date: new Date
    property string filter: ""
    id: container
    width: 1200
    height: 900
    color: "transparent"
    WidgetLabelUI {
        x: 555.5
        text: "FILTER"
        color: "#009EDF"
        font.pixelSize: 22
    }
    JSONListModel {
        id: filterModel
        source: "http://192.168.142.226/api/get_test_sequence_template_types.json"
        query: "$.data[*]"
    }

    Row {

        anchors.horizontalCenter: parent.horizontalCenter
        y: 32.5
        id: filterRow
        spacing: 16.5

        Repeater {
            model: filterModel.model
            WidgetButtonArrow {
                property bool toggle: filter
                height: 43
                label: model.name
                fontSize: 20
                fontBold: false
                onToggleChanged: {
                    isOn = filter == model.name
                }

                onClicked: {
                    if (filter != model.name) {
                        filter = ""
                        filter = model.name
                    } else {
                        filter = ""
                    }
                }
            }
        }
    }

    JSONListModel {
        id: passModel
        property int monthInc: container.date.getUTCMonth() + 1
        source: "http://192.168.142.226/api/get_passes.json?year=" + container.date.getUTCFullYear(
                    ) + "&mon=" + monthInc + "&day=" + container.date.getUTCDate()
        query: "$.passes[*]"
    }

    ListView {
        id: listView

        x: 45
        y: 100
        width: 1210
        height: 841
        clip: true
        spacing: -70
        orientation: ListView.Horizontal
        preferredHighlightBegin: listView.width / 2 - 166.5
        preferredHighlightEnd: listView.width / 2 + 166.5
        focus: true
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveVelocity: 1000

        model: passModel.model

        delegate: Rectangle {
            id: itemDelegate
            property real angleZ: 50
            property real side: 0

            opacity: (!filter || passType == filter) ? 1 : 0.25
            transform: Rotation {
                origin.x: width / 2
                origin.y: height / 2
                axis {
                    x: 0
                    y: side
                    z: 0
                }
                angle: angleZ
            }

            width: 323
            height: 840.764
            color: "transparent"
            Image {
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit
                source: "images/pass_item_bg.svg"
            }
            WidgetLabelUI {
                x: 42
                y: 10
                id: passText
                text: "PASS : " + name
            }
            property int date_station_order: index + 1
            property string source: "http://192.168.142.226/api/get_pass_operation_command_lists.json?date="
                                    + container.date.getUTCFullYear(
                                        ) + "%2F" + passModel.monthInc + "%2F"
                                    + container.date.getUTCDate(
                                        ) + "&date_station_order="
                                    + date_station_order + "&station=" + station
            property string passType: "NORMAL"
            property string information: ""
            Component.onCompleted: {
                console.log(source)
                var xhr = new XMLHttpRequest
                xhr.open("GET", source)
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == XMLHttpRequest.DONE) {
                        var jsonString = xhr.responseText
                        console.log(jsonString)
                        var json = JSON.parse(jsonString)
                        var data = json.data
                        if (data[0]) {
                            passType = data[index].pass_operation.pass_operation_type
                            information = data[index].pass_operation.prepass_comment ? data[index].pass_operation.prepass_comment : ""
                            missionText.text = "MISSION : " + passType
                        }
                    }
                }
                xhr.send()
            }

            WidgetLabelUI {
                x: 10
                y: 40
                id: missionText
                text: "MISSION : " + "NORMAL"
            }

            WidgetLabelUI {
                id: infotext
                x: 10
                y: 105
                width: parent.width - 20
                text: "    - " + information
                wrapMode: Text.Wrap
                verticalAlignment: Text.AlignTop
                font.pixelSize: 18
            }
            JSONListModel {
                id: testSeqModel
                source: "http://192.168.142.226/api/get_pass_operation_test_sequences.json?date="
                        + container.date.getUTCFullYear(
                            ) + "%2F" + passModel.monthInc + "%2F" + container.date.getUTCDate(
                            ) + "&date_station_order=" + date_station_order + "&station=" + station
                query: "$.data[*]"
            }
            JSONListModel {
                id: inComingTestSeqModel
                source: "http://192.168.142.226/api/get_pass_operation_command_lists.json?date="
                        + container.date.getUTCFullYear(
                            ) + "%2F" + passModel.monthInc + "%2F" + container.date.getUTCDate(
                            ) + "&date_station_order=" + date_station_order + "&station=" + station
                query: "$.data[*]"
            }
            TestSeqView {
                x: 7.521
                y: 238.005
                width: 307.242
                height: 594.855
                model: testSeqModel.model
                visible: los < Date.now() / 1000
            }
            TestSeqViewInComing {
                x: 7.521
                y: 238.005
                width: 307.242
                height: 594.855
                model: inComingTestSeqModel.model
                visible: los > Date.now() / 1000
            }
            MouseArea {
                id: idMouseAreaDown
                anchors.fill: parent
                onClicked: {
                    listView.currentIndex = index
                }
                onDoubleClicked: {
                    var comView = Qt.createComponent("ActivityPlan.qml")
                    window.stack.push({
                                          item: comView,
                                          properties: {
                                              window: window,
                                              model: inComingTestSeqModel.model,
                                              date_station_order: index + 1,
                                              station: station,
                                              date: aos_iso.substring(0, 10),
                                              name: name,
                                              passtype: passType,
                                              information: information,
                                              aos: aos_iso,
                                              los: los_iso,
                                              duration: duration
                                          }
                                      })
                }
            }

            Binding {
                target: itemDelegate
                property: "side"
                value: 0
                when: index == listView.currentIndex
            }

            Binding {
                target: itemDelegate
                property: "side"
                value: 1
                when: index < listView.currentIndex
            }

            Binding {
                target: itemDelegate
                property: "side"
                value: -1
                when: index > listView.currentIndex
            }

            Binding {
                target: itemDelegate
                property: "angleZ"
                value: 0
                when: index == listView.currentIndex
            }

            Binding {
                target: itemDelegate
                property: "angleZ"
                value: 50
                when: !(index == listView.currentIndex)
            }

            Binding {
                target: itemDelegate
                property: "scale"
                value: 1
                when: index == listView.currentIndex
            }
            Binding {
                target: itemDelegate
                property: "y"
                value: 0
                when: index == listView.currentIndex
            }

            Binding {
                target: itemDelegate
                property: "scale"
                value: 0.8
                when: !(index == listView.currentIndex)
            }
            Binding {
                target: itemDelegate
                property: "y"
                value: 40
                when: !(index == listView.currentIndex)
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 200
                    //                    easing.type: Easing.OutSine
                }
            }
            Behavior on y {
                NumberAnimation {
                    duration: 200
                    //                    easing.type: Easing.OutSine
                }
            }
            Behavior on x {
                NumberAnimation {
                    duration: 0
                    //                    easing.type: Easing.OutCirc
                }
            }

            Behavior on side {
                NumberAnimation {
                    duration: 200
                }
            }

            Behavior on angleZ {
                NumberAnimation {
                    duration: 200
                    //                    easing.type: Easing.OutSine
                }
            }
        }
    }
}
