import QtQuick 2.0

Rectangle {
    //    property var context
    id: container
    property var window
    property var date: new Date
    property int monthInc: container.date.getUTCMonth() + 1
    property int date_station_order
    property string station
    width: 1920
    height: 1080
    color: "black"
    Rectangle {
        id: content
        width: 1920
        height: 1080
        anchors.centerIn: parent
        scale: Math.min(container.width / content.width,
                        container.height / content.height)
        Image {
            id: imageBackground
            source: "images/bg1.png"
        }
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
                        if (passes[i].los < (Date.now() / 1000)
                                && passes[i + 1].los > (Date.now() / 1000)) {
                            passName.name = passes[i + 1].name
                            countdownTimer.alarmDateTime = passes[i + 1].los_iso
                            container.station = passes[i + 1].station
                            container.date_station_order = i + 2
                            currentTestSeqModel.source = "http://192.168.142.226/api/get_pass_operation_command_lists.json?date="
                                    + container.date.getUTCFullYear(
                                        ) + "%2F" + container.monthInc + "%2F"
                                    + container.date.getUTCDate(
                                        ) + "&date_station_order=" + container.date_station_order
                                    + "&station=" + passes[i + 1].station
                        }
                        if (passes[0].los > Date.now() / 1000) {
                            passName.name = passes[0].name
                            countdownTimer.alarmDateTime = passes[0].los_iso
                            container.station = passes[0].station
                            container.date_station_order = 1
                            //                        currentTestSeqModel.source =  "http://192.168.142.226/api/get_pass_operation_command_lists.json?date=2015%2F06%2F30&date_station_order="+container.date_station_order+"&station="+passes[i].station
                            currentTestSeqModel.source = "http://192.168.142.226/api/get_pass_operation_command_lists.json?date="
                                    + container.date.getUTCFullYear(
                                        ) + "%2F" + container.monthInc + "%2F"
                                    + container.date.getUTCDate(
                                        ) + "&date_station_order=" + container.date_station_order
                                    + "&station=" + passes[0].station
                            break
                        }
                    }
                }
            }
            xhr.send()
        }

        JSONListModel {
            id: currentTestSeqModel
            query: "$.data[*]"
            onCountChanged: {
                if (currentTestSeqModel.model.get(0)) {
                    widgetFormLabel.value = currentTestSeqModel.model.get(
                                0).pass_operation.pass_operation_type
                }
            }
        }

        WidgetLineWithInwardArrowsHorizontal {
            x: 27.211
            y: 325.987
            length: 296.225
        }
        WidgetLineWithInwardArrowsHorizontal {
            x: 27.211
            y: 361.98
            length: 296.225
        }
        WidgetLineWithInwardArrowsHorizontal {
            x: 27.211
            y: 396.647
            length: 296.225
        }

        WidgetFormLabel {
            id: widgetFormLabel
            x: 31.193
            y: 335.987
            keyWidth: 82.529
            key: "MISSION :"
            value: "" //Enter value here
        }

        WidgetFormLabel {
            x: 31.193
            y: 370.425
            keyWidth: 141.095
            key: "CONTROL MODE :"
            value: "MANUAL" //Enter value here
        }
        Rectangle {
            x: 27.211
            y: 417.753
            width: 141.409
            height: 25.333
            color: "#CC009CDD"
            WidgetLabelUI {
                id: commandListText
                anchors.centerIn: parent
                text: "COMMAND LIST"
                font.pixelSize: 16
            }
        }

        CountdownTimer {
            id: countdownTimer
            x: 70
            y: 30
        }

        Operators {
            x: 26.5
            y: 128.64
            showText: false
        }
        WidgetLineWithInwardArrowsHorizontal {
            length: 213
            x: 109.7
            y: 170
        }

        TcControl {
            id: tcControl
            x: 149.72
            y: 144.998
            width: 140.333
            height: 132.808
            onCurrentStateChanged: testSeqViewCurrent.running = currentState
        }

        TestSeqViewCurrent {
            id: testSeqViewCurrent
            x: 25.813
            y: 458.215
            width: 307.242
            height: 594.855
            running: tcControl.currentState
            model: currentTestSeqModel.model
            onError: {
                tcControl.currentState = false
            }
        }
        PassName {
            id: passName
            x: 362.555
            y: 22.215
            width: 293.709
            height: 96.425
        }
        PassTime {
            x: 680.802
            y: 17.248
            width: 466.669
            height: 102.752
        }
        AlarmWarning {
            x: 355.719
            y: 138.434
            width: 749.336
            height: 201.563
        }
        CommunicationLink {
            x: 355.719
            y: 349.342
            width: 316.333
            height: 137.178
        }
        Download {
            x: 743.721
            y: 370.425
            width: 361.334
            height: 116.095
            onCommandDoubleClicked: {
                var newObj = {
                    test_sequence: {
                        name: command
                    },
                    pass_operation: {
                        pass: {
                            station_name: container.station
                        }
                    }
                }
                testSeqViewCurrent.model.append(newObj)
            }
        }
        Clock {
            x: 1162.137
            y: 17.248
            width: 453.334
            height: 102.752
        }
        LogBook {
            x: 1120.055
            y: 137.471
            width: 789.945
            height: 291.723
        }
        JSONListModel {
            id: favouriteModel
            source: "http://192.168.142.226/api/get_favorite_test_sequences.json"
            query: "$.data[*]"
        }
        CommandGridView {
            x: 340.055
            y: 460.885
            model: favouriteModel.model
            onCommandDoubleClicked: {
                var newObj = {
                    test_sequence: {
                        name: command
                    },
                    pass_operation: {
                        pass: {
                            station_name: container.station
                        }
                    }
                }
                testSeqViewCurrent.model.append(newObj)
            }
        }
        CommandSearch {
            x: 1532.599
            y: 459.713
            width: 307.243
            height: 593.357
            onCommandDoubleClicked: {
                var newObj = {
                    test_sequence: {
                        name: command
                    },
                    pass_operation: {
                        pass: {
                            station_name: container.station
                        }
                    }
                }
                testSeqViewCurrent.model.append(newObj)
            }
        }
        WidgetLineWithInwardArrowsVertical {
            x: 1511.224
            y: 460.07
            length: 598.904
        }
    }
}
