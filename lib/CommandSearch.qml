import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import Qt.labs.folderlistmodel 1.0

Rectangle {
    id: commandSearch

    signal commandDoubleClicked(string command)
    color: "transparent"

    Image {
        id: background
        width: parent.width
        height: parent.height
        source: "images/search_command_bg.svg"
    }
    Rectangle {
        x: 5
        y: 34
        width: 295
        height: 40
        color: "transparent"
        border.color: "#009DCC"
        border.width: 1
    }
    TextField {
        id: searchField
        x: 6
        y: 35
        width: 290
        height: 38.048
        font.family: "Avenir"
        font.pixelSize: 14
        style: TextFieldStyle {
            textColor: "white"
            background: Rectangle {
                color: "transparent"
                implicitWidth: 290
                implicitHeight: 39
                //                border.color: "#009DCC"
                //                border.width: 1
            }
            selectionColor: "white"
            selectedTextColor: "black"
            placeholderTextColor: "#6D6D77"
        }
        placeholderText: qsTr("Search...")
        onTextChanged: {
            commandListModel.nameFilters = [text + "*" + commandListModel.tclFileExtention]
        }
    }
    Item {
        id: filter
        property string dir: "file:" + testEnv + "/VOSSCASEQ/Routine"
        x: 4
        y: 85

        FilterButton {
            id: firstBtn
            text: "Test Sequence"
            x: 0
            color: "#3FA9F5"
            onSelected: {
                if (firstBtn.state != "selected") {
                    firstBtn.state = "selected"
                    secondBtn.state = "normal"
                    thirdBtn.state = "normal"
                }
                firstSubBtn.state = "selected"
                secondSubBtn.state = "normal"
                thirdSubBtn.state = "normal"
                filter.dir = "file:" + testEnv + "/VOSSCASEQ/Routine"
                subFilter.visible = true
            }
        }
        FilterButton {
            id: secondBtn
            text: "Plugin"
            x: 100
            color: "transparent"
            onSelected: {
                if (secondBtn.state != "selected") {
                    firstBtn.state = "normal"
                    secondBtn.state = "selected"
                    thirdBtn.state = "normal"
                }
                filter.dir = "file:" + testEnv + "/VOSSCASEQ/Plugin"
                subFilter.visible = false
            }
        }
        FilterButton {
            id: thirdBtn
            text: "Direct Command"
            x: 200
            color: "transparent"
            onSelected: {
                if (thirdBtn.state != "selected") {
                    firstBtn.state = "normal"
                    secondBtn.state = "normal"
                    thirdBtn.state = "selected"
                }
                filter.dir = "file:" + testEnv + "/VOSSCASEQ/Direct_Command"
                subFilter.visible = false
            }
        }
        Item {
            id: subFilter

            y: 29
            FilterButton {
                id: firstSubBtn
                sub: true
                text: "Routine"
                x: 0
                color: "#276991"
                onSelected: {
                    if (firstSubBtn.state != "selected") {
                        firstSubBtn.state = "selected"
                        secondSubBtn.state = "normal"
                        thirdSubBtn.state = "normal"
                        filter.dir = "file:" + testEnv + "/VOSSCASEQ/Routine"
                    }
                }
            }
            FilterButton {
                id: secondSubBtn
                text: "Anomaly"
                sub: true
                x: 100
                color: "transparent"
                onSelected: {
                    if (secondSubBtn.state != "selected") {
                        firstSubBtn.state = "normal"
                        secondSubBtn.state = "selected"
                        thirdSubBtn.state = "normal"
                        filter.dir = "file:" + testEnv + "/VOSSCASEQ/Anomaly"
                    }
                }
            }
            FilterButton {
                id: thirdSubBtn
                text: "Maintenance"
                sub: true
                x: 200
                color: "transparent"
                onSelected: {
                    if (thirdSubBtn.state != "selected") {
                        firstSubBtn.state = "normal"
                        secondSubBtn.state = "normal"
                        thirdSubBtn.state = "selected"
                        filter.dir = "file:" + testEnv + "/VOSSCASEQ/Maintenance"
                    }
                }
            }
        }

        Component.onCompleted: {
            firstBtn.state = "selected"
            firstSubBtn.state = "selected"
        }
    }

    ListView {
        id: commandListView

        clip: true
        y: 160
        width: parent.width
        height: 640
        model: FolderListModel {
            id: commandListModel
            property string tclFileExtention: "*.tcl"
            showDirs: false
            folder: filter.dir
            nameFilters: [tclFileExtention]
        }

        add: Transition {
            NumberAnimation {
                properties: "y"
                duration: 600
                easing.type: Easing.OutBack
            }
        }

        delegate: MouseArea {
            id: delegateRoot
            width: parent.width
            height: 34
            drag.target: icon
            objectName: fileBaseName
            property bool allowInsert: true
            Image {
                id: arrow
                height: 20
                width: 20
                sourceSize.width: 50
                sourceSize.height: 50
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 5
                }

                source: "images/arrows/indicate_arrow_blue.svg"
            }

            Rectangle {
                width: 253
                height: 30
                id: icon
                color: "transparent"
                border.color: "#009DCC"
                border.width: 1
                clip: true
                WidgetLabelUI {
                    id: iconText
                    x: 10
                    y: 3
                    width: parent.width - 10
                    text: fileBaseName
                    color: "#009DCC"
                    wrapMode: Text.Wrap
                    font.family: "Avenir"
                }
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 30
                }
                Drag.active: delegateRoot.drag.active
                Drag.source: delegateRoot
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: [
                    State {
                        when: icon.Drag.active
                        ParentChange {
                            target: icon
                            parent: commandSearch.parent
                        }

                        AnchorChanges {
                            target: icon
                            anchors.left: undefined
                            anchors.verticalCenter: undefined
                        }
                        PropertyChanges {
                            target: arrow
                            visible: false
                        }
                    }
                ]
            }
            onPressed: {
                icon.color = "#009EDF"
                iconText.color = "white"
            }
            onReleased: {
                icon.color = "transparent"
                iconText.color = "#009DCC"
                arrow.visible = true
                icon.Drag.drop()
            }
            onDoubleClicked: {
                commandDoubleClicked(fileBaseName)
            }
        }
    }
    WidgetScrollBar {
        flickable: commandListView
        clip: true
    }
}
