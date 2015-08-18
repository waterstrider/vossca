import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQml.Models 2.1

Rectangle {
    id: container
    property ListModel model
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
                properties: "x,y"
                easing.type: Easing.OutQuad
            }
        }
        model: DelegateModel {

            id: visualModel
            model: container.model
            delegate: MouseArea {
                property int visualIndex: DelegateModel.itemsIndex
                property int realIndex: index
                id: delegateRoot
                width: 280
                height: 30
                drag.target: icon
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
                        visualModel.items.move(drag.source.visualIndex,
                                               delegateRoot.visualIndex)
                        container.model.move(drag.source.realIndex,
                                             delegateRoot.realIndex, 1)
                    }
                }
            }
        }
    }
    WidgetScrollBar {
        handleSize: 15
        flickable: root
    }
}
