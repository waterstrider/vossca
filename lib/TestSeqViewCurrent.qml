import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQml.Models 2.1
import QtQuick.Dialogs 1.1
import QtGraphicalEffects 1.0
import com.terma.TSEQ 1.0

Rectangle {
    id: container
    property ListModel model
    property int nextIdleIndex: 0
    property bool running: false
    property int errorCount: 0
    property var date: new Date
    signal error
    color: "transparent"

    Image {
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        source: "images/command_list_bg.svg"
    }
    ListView {
        id: root
        clip: true
        x: 4.8
        y: 20
        width: 308
        height: 530
        spacing: 5
        displaced: Transition {
            NumberAnimation {
                properties: "y"
                easing.type: Easing.OutQuad
            }
        }
        model: DelegateModel {
            id: visualModel
            model: container.model
            delegate: MouseArea {
                property int nextIdleIndex: container.nextIdleIndex
                property bool running: container.running
                property int visualIndex: DelegateModel.itemsIndex
                property int realIndex: index
                id: delegateRoot
                width: 280
                height: 30
                drag.target: icon
                onReleased: icon.Drag.drop()

                onRunningChanged: {
                    if (delegateRoot.nextIdleIndex == index) {
                        if (container.running) {
                            testSequence.start()
                            icon.Drag.active = false
                        }
                    }
                }
                onNextIdleIndexChanged: {
                    if (delegateRoot.nextIdleIndex == index) {
                        if (container.running) {
                            testSequence.start()
                            icon.Drag.active = false
                        }
                    }
                }
                drag.onActiveChanged: {
                    if (delegateRoot.realIndex < container.nextIdleIndex) {
                        icon.Drag.active = false
                    }
                    trashArea.visible = drag.active
                }

                WidgetButtonItem {
                    id: icon
                    width: 280
                    height: 30
                    labelLeft: delegateRoot.visualIndex + 1
                    labelLeftMargin: 5
                    borderColor: "#009DCC"
                    bgColorPressed: "#009DCC"
                    textColor: "#FFFFFF"
                    label: test_sequence.name
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    Drag.active: delegateRoot.drag.active
                    Drag.source: delegateRoot
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2

                    Image {
                        id: image
                        x: 280 - width - 5
                        fillMode: Image.PreserveAspectFit
                        height: 30
                        source: "images/lid_white.svg"
                    }

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: trashArea
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
                DropArea {
                    anchors {
                        fill: parent
                    }
                    onEntered: {
                        if (!(delegateRoot.realIndex < container.nextIdleIndex)) {
                            visualModel.items.move(drag.source.visualIndex,
                                                   delegateRoot.visualIndex)
                            container.model.move(drag.source.realIndex,
                                                 delegateRoot.realIndex, 1)
                        }
                    }
                }
                MessageDialog {
                    id: messageDialog
                    visible: false
                    modality: visible ? Qt.WindowModal : Qt.NonModal
                    title: "ERROR"
                    onAccepted: {
                        testSequence.terminate()
                    }
                }
                TestSequence {
                    id: testSequence
                    property bool isError: false
                    script: test_sequence.name
                    onStateChanged: {
                        if (state == "ERROR") {
                            container.error()
                            errorCount++
                            isError = true
                            container.running = false
                            messageDialog.text = lastError
                            messageDialog.visible = true
                            image.source = "images/lid_red.svg"
                        }

                        if (state == "TERMINATED") {
                            container.nextIdleIndex++
                            if (!(isError)) {
                                var monthInc = container.date.getUTCMonth()
                                console.log("http://192.168.142.226/api/get_pass_operation_test_sequences.json?date="
                                            + container.date.getUTCFullYear(
                                                ) + "%2F" + monthInc
                                            + "%2F" + container.date.getUTCDate(
                                                ) + "&date_station_order="
                                            + date_station_order + "&station="
                                            + pass_operation.pass.station_name)
                                var xhr = new XMLHttpRequest
                                xhr.open("GET",
                                         "http://192.168.142.226/api/get_pass_operation_test_sequences.json?date=2015%2F07%2F07&date_station_order=" + 2
                                         + "&station=" + pass_operation.pass.station_name)
                                xhr.onreadystatechange = function () {
                                    if (xhr.readyState == XMLHttpRequest.DONE) {
                                        var jsonString = xhr.responseText
                                        console.log(jsonString)
                                        var json = JSON.parse(jsonString)
                                        var data = json.data
                                        if (data) {
                                            console.log(index - errorCount,
                                                        data[index - errorCount].ts_status)
                                            image.source = data[index - errorCount].ts_status == "OK" ? "images/lid_green.svg" : "images/lid_red.svg"
                                        }
                                    }
                                }
                                xhr.send()
                            }
                        }
                    }
                }
            }
        }
    }
    WidgetScrollBar {
        handleSize: 15
        flickable: root
    }
    Item {
        id: trashArea
        width: parent.width - 2
        height: 200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        visible: false
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, 150)
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "transparent"
                }
                GradientStop {
                    position: 1.0
                    color: "#000000"
                }
            }
        }
        Image {
            id: trash
            sourceSize: Qt.size(50, 50)
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 40
            source: "images/icons/trash_can_close_blue.svg"
        }
        DropArea {
            anchors.fill: parent
            onEntered: {
                trash.source = "images/icons/trash_can_open_orange.svg"
            }
            onExited: {
                trash.source = "images/icons/trash_can_close_blue.svg"
            }
            onDropped: {

                container.model.remove(drag.source.realIndex)
                trash.source = "images/icons/trash_can_close_blue.svg"
            }
        }
    }
}
