import QtQuick 2.0

Rectangle {
    id: container
    property var window
    property ListModel model
    property string station
    property int date_station_order
    property string date
    property string passtype
    property string information
    property string name
    property string aos
    property string loss
    property string duration
    width: 1920
    height: 1080
    color: "black"
    Component.onCompleted: console.log("information", information)
    Image {
        id: imageBackground
        source: "images/bg1.png"
    }
    Operators {
        x: 18
        y: 170
    }
    Rectangle {
        x: 344.568
        y: 36.516
        width: 312.424
        height: 27.57
        color: "#CC009CDD"
    }
    WidgetLabelUI {
        x: 351.355
        y: 40.431
        id: text
        text: "ACTIVITY PLAN SCHEDULE"
    }

    Date {
        x: 714.5
        y: 17.083
        width: 619
        height: 63.417
    }
    Clock {
        x: 1460.152
        y: 13.428
        width: 453.334
        height: 102.752
    }
    CalendarMonth {
        x: 1604.5
        y: 131.5
        width: 307
        height: 172
        onMonthClicked: {
            window.stack.pop()
            window.stack.pop()
        }
        onDayClicked: {
            window.stack.pop()
            window.stack.pop()
        }
    }
    CommandTemplate {
        x: 9.5
        y: 378.999
        width: 297.125
        height: 700
        testSeqModel: container.model
        onTemplateDoubleClicked: {
            testSeqGridView.initBlank = false
            container.passtype = commandType
            testSeqGridView.passtype = commandType
        }
    }
    TestSeqGridView {
        id: testSeqGridView
        model: container.model
        x: 389.5
        y: 180.5
        width: 1012
        height: 871
        date: container.date
        passtype: container.passtype
        initInformationText: container.information
        name: container.name
        aos: container.aos
        los: container.los
        duration: container.duration
    }
    Image {
        id: saveButton

        x: 1428.012
        y: 216.5

        source: "images/custom/test_seq_grid_view/save_cornered_rectangle_right_grey_60.svg"

        MouseArea {
            anchors.fill: parent
            onPressed: saveButton.source = "images/custom/test_seq_grid_view/save_cornered_rectangle_right_yellow_60.svg"
            onReleased: saveButton.source = "images/custom/test_seq_grid_view/save_cornered_rectangle_right_grey_60.svg"
            onExited: saveButton.source
                      = "images/custom/test_seq_grid_view/save_cornered_rectangle_right_grey_60.svg"
            onClicked: {
                console.log("http://192.168.142.226/api/set_pass_operation_command_lists.json")
                var xhr = new XMLHttpRequest
                xhr.open("POST",
                         "http://192.168.142.226/api/set_pass_operation_command_lists.json")
                xhr.setRequestHeader("Content-type",
                                     "application/json;charset=UTF-8")

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == XMLHttpRequest.UNSENT) {
                        console.log("UNSENT")
                    }
                    if (xhr.readyState == XMLHttpRequest.OPENED) {
                        console.log("OPENED")
                    }
                    if (xhr.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                        console.log("HEADERS_RECEIVED")
                    }
                    if (xhr.readyState == XMLHttpRequest.LOADING) {
                        console.log("LOADING")
                    }
                    if (xhr.readyState == XMLHttpRequest.DONE) {
                        console.log("DONE")
                        console.log(xhr.responseText)
                        console.log(xhr.statusText)
                    }
                }
                var temp = ""
                var json = "{"

                temp = container.model.get(
                            0).pass_operation //.pass.station_name
                json += temp ? "\"station\":\"" + temp.pass.station_name
                               + "\"," : "\"station\":\"" + station + "\","

                temp = container.model.get(0).pass_operation //.pass_id
                json += temp ? "\"pass_id\":" + temp.pass_id + "," : ""

                temp = container.model.get(0).pass_operation_id
                json += temp ? "\"pass_operation_id\":" + temp + "," : ""

                temp = container.model.get(
                            0).pass_operation //.pass.calendar_date
                json += temp ? "\"date\":\"" + temp.pass.calendar_date
                               + "\"," : "\"date\":\"" + date.substring(
                                   0, 4) + "/" + date.substring(
                                   5, 7) + "/" + date.substring(8, 10) + "\","

                temp = container.date_station_order
                json += temp ? "\"date_station_order\":" + temp
                               + "," : "\"date_station_order\":" + date_station_order + ","

                json += "\"pass_operation_type_name\":\"" + container.passtype + "\","

                json += "\"prepass_comment\":\"" + testSeqGridView.getText(
                            ) + "\","

                temp = container.model.get(0).test_sequence //.name
                json += temp ? "\"data\":[{\"ts_name\":\"" + temp.name + "\"}" : ""

                for (var i = 1; i < container.model.count - 1; i++) {
                    temp = container.model.get(i).test_sequence //.name
                    json += temp ? ",{\"ts_name\":\"" + temp.name + "\"}" : ""
                }
                json += "]}"
                console.log(json)
                xhr.send(json)

                console.log("http://192.168.142.226/api/set_pass_operation_type.json")
                xhr = new XMLHttpRequest
                xhr.open("POST",
                         "http://192.168.142.226/api/set_pass_operation_type.json")
                xhr.setRequestHeader("Content-type",
                                     "application/json;charset=UTF-8")
                xhr.send(json)

                console.log("http://192.168.142.226/api/set_pass_operation.json")
                xhr = new XMLHttpRequest
                xhr.open("POST",
                         "http://192.168.142.226/api/set_pass_operation.json")
                xhr.setRequestHeader("Content-type",
                                     "application/json;charset=UTF-8")
                xhr.send(json)
            }
        }
    }
    Image {
        x: 1855.058
        y: 418.648
        source: "images/icons/quick_menu_sat.svg"
        sourceSize.width: 56
        sourceSize.height: 65
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                var comView = Qt.createComponent("LiveSession.qml")
                window.stack.push({
                                      item: comView,
                                      properties: {
                                          window: window
                                      }
                                  })
            }
        }
    }

    CommandSearch {
        x: 1494.202
        y: 361.918
        width: 307.242
        height: 681.168
        onCommandDoubleClicked: {
            testSeqGridView.addCommandWithBlank(command)
        }
    }

    WidgetLabelUI {
        y: 136.899
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#009EDF"
        text: "DATE & TIME ACTIVITY"
        font.pixelSize: 28
    }

    WidgetLineWithInwardArrowsHorizontal {
        id: countdownBeforeTopLine

        x: 20.401
        y: 364.78
        length: 296.225
    }

    WidgetLineWithInwardArrowsVertical {
        id: countdownBeforeRightLine

        x: 316.625
        y: 378.692
        length: 688.776
    }

    WidgetLineWithInwardArrowsHorizontal {
        id: testSeqTopLine

        x: 339.45
        y: 173.667
        length: 1256.109
    }

    WidgetLineWithInwardArrowsHorizontal {
        id: testSeqBottomLine

        x: 339.45
        y: 1067.469
        length: 1256.109
    }

    WidgetLineWithInwardArrowsVertical {
        id: searchCommandLeftLine

        x: 1469.524
        y: 364.276
        length: 688.776
    }
}
