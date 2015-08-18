import QtQuick 2.3
import QtQml.Models 2.1
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Rectangle {
    id: container
    property ListModel model
    property string date
    property string passtype
    property string initInformationText
    property string name
    property string aos
    property string los
    property string duration
    property bool initBlank: false
    onPasstypeChanged: {
        passStatus.setTypeText(passtype)
    }
    function getText() {
        return infoTextArea.getText(0, infoTextArea.length)
    }
    function addCommandWithBlank(command) {
        var newObj = {
            test_sequence: {
                name: command
            }
        }
        container.model.set(root.blankRealIndex, newObj)
        container.model.move(root.blankRealIndex, root.tmpBlankRealIndex, 1)
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
    Component.onDestruction: container.model.remove(container.model.count - 1)
    color: "transparent"

    Image {
        source: "images/custom/test_seq_grid_view/main_frame_cornered_rectangle_both.svg"
        anchors.centerIn: parent
    }

    Rectangle {
        id: passStatus

        property string date: container.date
        property string passtype: container.passtype
        property string name: container.name
        property string aos: container.aos
        property string los: container.los
        property string duration: container.duration
        property string typeText: ""
        property string nameText: ""
        property string dateTimeText: ""

        Component.onCompleted: {
            setTypeText(passtype)
            setNameText(name)
            setDateTimeText(date, aos, los, duration)
        }

        function setTypeText(passtype) {
            var txt = "MISSION : "
            txt += passtype.toUpperCase()
            passStatus.typeText = txt
        }

        function setNameText(name) {
            var txt = "PASS NAME : "
            txt += name.toUpperCase()
            passStatus.nameText = txt
        }

        function str_pad_left(string, pad, length) {
            return (new Array(length + 1).join(pad) + string).slice(-length)
        }

        function setDateTimeText(date, aos, los, duration) {

            var aosWithoutDate = aos.substring(11).substring(0, 8)
            var losWithoutDate = los.substring(11).substring(0, 8)

            var txt = "DATE "
            txt += date
            txt += " : "
            txt += "AOS "
            txt += aosWithoutDate
            txt += " - "
            txt += "LOS "
            txt += losWithoutDate
            txt += " | "
            txt += "Duration "
            txt += str_pad_left(Math.floor(duration / 60), '0',
                                2) + ':' + str_pad_left(
                        Math.round(duration - (Math.floor(
                                                   duration / 60) * 60)), '0',
                        2)
            txt += " min"

            passStatus.dateTimeText = txt
        }

        color: "transparent"
        width: 962
        height: 210

        anchors.top: parent.top
        anchors.topMargin: 6.5
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: dateTimeActivity

            width: 962
            height: 47
            color: "transparent"

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            WidgetButton {
                enabled: false
                color: "#66CC33"
                label: passStatus.dateTimeText
                width: parent.width
                labelAlignment: Text.AlignHCenter
                fontSize: 27

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                opacity: 0.6 //60%
            }
        }

        Rectangle {
            id: session

            y: 63.26
            width: 310
            height: 101.24
            color: "transparent"

            anchors.left: parent.left

            WidgetLabelUI {
                id: sessionLabel

                height: 27.419
                text: "SESSION"

                anchors.top: parent.top
                anchors.left: parent.left
            }

            Rectangle {
                id: passName

                color: "transparent"

                y: 33.24
                width: 310
                height: 32.667

                anchors.horizontalCenter: parent.horizontalCenter

                WidgetLabelUI {
                    id: passNameText

                    text: passStatus.nameText
                    anchors.left: parent.left
                    anchors.leftMargin: 18.034
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    source: "images/custom/test_seq_grid_view/pass_name_cornered_rectangle_both_blue_40.svg"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                id: missionType

                color: "transparent"

                y: 71.24
                width: 310
                height: 32.667

                anchors.horizontalCenter: parent.horizontalCenter

                WidgetLabelUI {
                    id: missionTypeText

                    text: passStatus.typeText
                    anchors.left: parent.left
                    anchors.leftMargin: 18.034
                    anchors.verticalCenter: parent.verticalCenter
                }

                Image {
                    source: "images/custom/test_seq_grid_view/mission_rectangle_blue_40.svg"
                    anchors.centerIn: parent
                }
            }
        }

        Rectangle {
            id: information

            y: 63.26
            width: 617.692
            height: 147.24
            color: "transparent"

            anchors.right: parent.right

            WidgetLabelUI {
                id: informationLabel

                width: 147.279
                height: 27.419
                text: "INFORMATION"

                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                y: 33.24
                source: "images/custom/test_seq_grid_view/information_cornered_rectangle_left_blue_40.svg"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextArea {
                id: infoTextArea

                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                width: parent.width - 30
                height: 100
                text: container.initInformationText
                backgroundVisible: false
                frameVisible: false

                style: TextAreaStyle {
                    textColor: "white"
                    backgroundColor: "transparent"

                    selectionColor: "white"
                    selectedTextColor: "black"
                }
                wrapMode: TextEdit.Wrap
                font.pixelSize: 18
                font.family: "Avenir"
            }
        }
    }

    WidgetLabelUI {

        x: 44
        y: 185.836

        text: "COMMAND LIST"
        font.pixelSize: 22
        color: "#009EDF"
    }

    Image {
        id: trashCan

        anchors.right: root.right
        anchors.bottom: root.bottom
        source: "images/icons/trash_can_close_blue.svg"
        DropArea {
            onEntered: parent.source = "images/icons/trash_can_open_orange.svg"
            onExited: parent.source = "images/icons/trash_can_close_blue.svg"
            anchors {
                fill: parent
            }
            onDropped: {
                if (!drag.source.allowInsert) {
                    container.model.remove(drag.source.index)
                }
                parent.source = "images/icons/trash_can_close_blue.svg"
            }
        }
    }

    GridView {
        id: root

        property int blankRealIndex
        property int tmpBlankRealIndex
        property int blankVisualIndex
        property int tmpBlankVisualIndex

        x: 48
        y: 234
        width: 941
        height: 608
        cellWidth: 313
        cellHeight: 60
        interactive: false
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
                width: 313
                height: 60
                drag.target: icon
                objectName: test_sequence.name
                opacity: test_sequence.name == "" ? 0 : 1
                onReleased: icon.Drag.drop()
                WidgetButtonItem {
                    id: icon
                    width: 290
                    height: 48
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
