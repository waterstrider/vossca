// /////////////////////////////////////////////////////////////////////////////////////////
// Widget Name: CommandTemplate
// /////////////////////////////////////////////////////////////////////////////////////////
// Historical revue:
// -----------------------------------------------------------------------------------------
// Version  |   Date        |   Author      |   Comments
//
//  v0.0    |   02/06/15    |   S. Chanate  |   Creation
//
//  v0.4    |   08/06/15    |   S. Chanate  |   Change from ListModel to JSONListModel
//  v0.5    |   09/06/15    |   S. Chanate  |   Do single item selection
//  v0.6    |   15/07/15    |   S. Chanate  |   Change commandTemplateHeadRect opacity to 50%
// -----------------------------------------------------------------------------------------
// /////////////////////////////////////////////////////////////////////////////////////////
// Objective of the widget:
// This widget aims to create a simple display of available "Command Pass", catergorize by
// "Command Groups".
// /////////////////////////////////////////////////////////////////////////////////////////

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: container
    signal templateDoubleClicked(string commandType)
    property ListModel testSeqModel
    property color textColor: "#FFFFFF"
    property int leftMarginValue: 10
    property int topMarginValue: 5
    property int attributeBoxShrinkValue: 10
    property int gap: 10
    property color bgColor: "transparent"
    property color borderColor: "#009DCC"
    property color colorPressed: "#458429"

    width: 300
    height: 480
    color: bgColor

    Rectangle {
        id: commandTemplateHeadRect
        width: parent.width
        height: 43 //value from WidgetButton.qml
        color: "#6DCFF6"
        opacity: 0.5
        WidgetLabelUI {
            id: commandTemplateHeadText
            anchors.centerIn: parent
            color: textColor
            text: "COMMAND TEMPLATE"
        }
    }

    ListView {
        id:listView
        anchors.fill: parent
        anchors.topMargin: commandTemplateHeadRect.height + gap
        model: groupModel.model
        delegate: groupDelegate
        section.delegate: groupDelegate
        interactive: false
    }

    JSONListModel {
        id: groupModel

        source: "http://192.168.142.226/api/get_test_sequence_template_types.json"
        query: "$.data[*]"

        function attributesCounter(index) {
            return groupModel.model.get(index).test_sequence_templates.count
        }

    }

    Component {
        id: groupDelegate

        Column {
            id: groupColumn
            width: container.width

            WidgetButtonCornered {
                id: groupButton

                property bool collapsed: true

                width: parent.width
                WidgetLabelUI {
                    id: groupText
                    anchors.fill: parent
                    anchors.leftMargin: leftMarginValue
                    color: textColor
                    text: model.name
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: groupButton.collapsed = !groupButton.collapsed
                }
            }
            Rectangle {
                width: parent.width - attributeBoxShrinkValue
                height: groupButton.height * groupModel.attributesCounter(index)
                border.color: borderColor
                visible: !groupButton.collapsed
                color: bgColor
                anchors.horizontalCenter: parent.horizontalCenter

                Loader {
                    id: itemLoader
                    width: parent.width
                    sourceComponent: groupButton.collapsed ? null : itemDelegate
                    asynchronous: true
                    onStatusChanged: {
                        if (status == Loader.Ready){
                            item.model = model.test_sequence_templates
                            item.passType = model.name
                        }


                    }
                }
            }
        }
    }

    Component {
        id: itemDelegate
        Column {
            id: itemColumn
            property alias model: itemRepeater.model
            property string passType

            Repeater {
                id: itemRepeater

                delegate: WidgetButtonArrow {
                    id: itemButton

                    property int checkmarkRightMargin: 20

                    signal itemSelected(string item)

                    width: parent.width
                    borderColor: bgColor
                    label: name
                    fontBold: false
                    isArrowVisible: false

                    Image {
                        id: checkmarkImage

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: checkmarkRightMargin
                        source: "images/button_agree.png"
                        visible: false
                    }

                    MouseArea {
                        anchors.fill: parent
                        propagateComposedEvents: true
                        hoverEnabled: true
                        onEntered: isArrowVisible = true
                        onExited: isArrowVisible = false
                        onPressed: {
                            color = colorPressed
                            entered()
                        }
                        onReleased: {
                            color = bgColor
                            exited()
                        }
                        onDoubleClicked: {
                            itemButton.itemSelected(item)
                            checkmarkImage.visible = true
                            container.testSeqModel.clear()
                            for(var i = 0;i<test_sequences.count;i++){
                                var newObj = {
                                    test_sequence: {
                                        name: test_sequences.get(i).name
                                    }
                                }
                                container.testSeqModel.append(newObj)
                            }
                            templateDoubleClicked(itemColumn.passType)
                        }
                    }
                }
            }
        }
    }
}
