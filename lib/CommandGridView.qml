import QtQuick 2.3
import QtQml.Models 2.1

Rectangle {
    id: container
    property ListModel model
    signal commandDoubleClicked(string command)
    property bool initBlank: false

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: false
        onTriggered: {
            if (initBlank) {
                if (!container.model.get(root.blankRealIndex)) {
                    initBlank = false
                } else if (container.model.get(
                               root.blankRealIndex).test_sequence.name != "") {
                    initBlank = false
                }
            }
        }
    }
    onInitBlankChanged: {
        if (!initBlank) {
            var newObj = {
                test_sequence: {
                    name: ""
                }
            }
            root.blankRealIndex = container.model.count
            root.tmpBlankRealIndex = container.model.count
            root.blankVisualIndex = container.model.count
            root.tmpBlankVisualIndex = container.model.count
            container.model.append(newObj)
            initBlank = true
        }
    }

    onModelChanged: {
        if (!initBlank) {
            var newObj = {
                test_sequence: {
                    name: ""
                }
            }
            root.blankRealIndex = container.model.count
            root.tmpBlankRealIndex = container.model.count
            root.blankVisualIndex = container.model.count
            root.tmpBlankVisualIndex = container.model.count
            container.model.append(newObj)
            initBlank = true
        }
    }
    color: "transparent"
    WidgetButtonCornered {
        x: 990
        width: 33.068
        height: 30.602
        label: "1"
    }
    WidgetButtonCornered {
        x: 1028
        width: 33.068
        height: 30.602
        label: "2"
    }
    WidgetButtonCornered {
        x: 1064
        width: 33.068
        height: 30.602
        label: "3"
    }
    WidgetButtonCornered {
        x: 1102
        width: 33.068
        height: 30.602
        label: "4"
    }

    WidgetLineWithInwardArrowsHorizontal {
        y: 40
        length: 1142
    }
    WidgetLineWithInwardArrowsHorizontal {
        y: 600
        length: 1142
    }
    GridView {
        id: root
        property int blankRealIndex
        property int tmpBlankRealIndex
        property int blankVisualIndex
        property int tmpBlankVisualIndex
        x: 15
        y: 51
        width: 1137.338
        height: 541.342
        interactive: false
        cellWidth: 379.333
        cellHeight: 132.67

        clip: true
        flow: GridView.TopToBottom
        displaced: Transition {
            NumberAnimation {
                properties: "x,y"
                easing.type: Easing.OutQuad
            }
        }
        model: DelegateModel {
            id: visualModel
            model: container.model
            delegate: MouseArea {
                id: delegateRoot
                property int realIndex: index
                property int visualIndex: DelegateModel.itemsIndex
                property bool allowInsert: false
                onRealIndexChanged: {
                    console.log("http://192.168.142.226/api/set_favorite_test_sequence.json")
                    var xhr = new XMLHttpRequest
                    xhr.open("POST",
                             "http://192.168.142.226/api/set_favorite_test_sequence.json")
                    xhr.setRequestHeader("Content-type",
                                         "application/json;charset=UTF-8")

                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == XMLHttpRequest.DONE) {
                            console.log("DONE")
                            console.log(xhr.responseText)
                            console.log(xhr.statusText)
                        }
                    }
                    var json = "{"

                    json += "\"ts_name\":\"" + test_sequence.name + "\","

                    json += "\"order_no\":" + delegateRoot.realIndex

                    json += "}"
                    console.log(json)
                    xhr.send(json)
                }

                width: 368.333
                height: 132.67
                drag.target: icon
                objectName: test_sequence.name
                opacity: test_sequence.name == "" ? 0 : 1
                onReleased: icon.Drag.drop()
                onDoubleClicked: commandDoubleClicked(test_sequence.name)
                Rectangle {
                    id: icon
                    //                    anchors.centerIn: parent
                    width: 368.333
                    height: 122.67
                    color: "transparent"
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    Drag.active: test_sequence.name == "" ? 0 : delegateRoot.drag.active
                    Drag.source: delegateRoot
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                    Image {
                        anchors.fill: parent
                        id: bg
                        source: "images/command_item_bg.svg"
                    }
                    WidgetLabelUI {
                        x: 7
                        y: 7
                        text: test_sequence.name
                        color: "#3FA9F5"
                        font.pixelSize: 14
                    }
                    Rectangle {
                        width: 92.326
                        height: 69.654
                        y: 30
                        x: 7
                        color: "transparent"
                        border.width: 1
                        border.color: "#3FA9F5"
                        WidgetLabelUI {
                            anchors.centerIn: parent
                            text: "PICTURE"
                            color: "#3FA9F5"
                            font.pixelSize: 11
                        }
                    }
                }

                DropArea {
                    anchors {
                        fill: parent
                    }
                    onEntered: {
                        if (!(delegateRoot.realIndex == root.blankRealIndex)) {
                            if (drag.source.allowInsert) {
                                root.tmpBlankRealIndex = delegateRoot.realIndex
                                root.tmpBlankVisualIndex = delegateRoot.visualIndex
                                visualModel.items.move(root.blankVisualIndex,
                                                       delegateRoot.visualIndex)
                                root.blankVisualIndex = root.tmpBlankVisualIndex
                            } else {
                                visualModel.items.move(drag.source.visualIndex,
                                                       delegateRoot.visualIndex)
                                container.model.move(drag.source.realIndex,
                                                     delegateRoot.realIndex, 1)
                            }
                        }
                    }
                    onDropped: {
                        if (drag.source.allowInsert) {
                            var newObj = {
                                test_sequence: {
                                    name: drag.source.objectName
                                }
                            }
                            container.model.set(root.blankRealIndex, newObj)
                            container.model.move(root.blankRealIndex,
                                                 root.tmpBlankRealIndex, 1)

                            console.log("http://192.168.142.226/api/set_favorite_test_sequence.json")
                            var xhr = new XMLHttpRequest
                            xhr.open("POST",
                                     "http://192.168.142.226/api/set_favorite_test_sequence.json")
                            xhr.setRequestHeader(
                                        "Content-type",
                                        "application/json;charset=UTF-8")

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState == XMLHttpRequest.DONE) {
                                    console.log("DONE")
                                    console.log(xhr.responseText)
                                    console.log(xhr.statusText)
                                }
                            }
                            var json = "{"

                            json += "\"ts_name\":\"" + drag.source.objectName + "\","

                            json += "\"order_no\":" + root.tmpBlankRealIndex

                            json += "}"
                            console.log(json)
                            xhr.send(json)
                            newObj = {
                                test_sequence: {
                                    name: ""
                                }
                            }
                            root.blankRealIndex = container.model.count
                            root.tmpBlankRealIndex = container.model.count
                            root.blankVisualIndex = container.model.count
                            root.tmpBlankVisualIndex = container.model.count
                            container.model.append(newObj)
                        }
                    }
                }
            }
        }
    }
}
