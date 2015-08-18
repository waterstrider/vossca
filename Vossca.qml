import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1
import "./lib"

Rectangle {
    property var window: stackView
    id: content
    width: 1920
    height: 1080
    color: "black"
    StackView {
        id: stackView
        width: 1920
        height: 1080
        scale: Math.min(content.width / container.width,
                        content.height / container.height)
        anchors.centerIn: parent
        initialItem: container
    }
    WidgetWindowControl {
        id: windowControl
        z: 90
        anchors.top: parent.top
        anchors.right: parent.right
        visible: rootView.visibility == Window.FullScreen
        onMinimize: rootView.visibility = Window.Minimized
        onToggle: rootView.fullScreen = !rootView.fullScreen
        onClose: rootView.close()
    }
    Rectangle {
        id: container
        width: 1920
        height: 1080
        anchors.centerIn: parent
        color: "black"
        Component.onCompleted: {
            console.log("Main window loaded")
            rootView.visibilityChanged.connect(adjustFullScreen)
        }
        Component.onDestruction: {
            console.log("Main window to be destructed")
        }
        function adjustFullScreen() {
            if (rootView.visibility == Window.Maximized)
                rootView.fullScreen = true
        }
        Image {
            id: imageBackground
            source: "lib/images/bg1.png"
        }
        Image {
            y: 147
            id: logo
            sourceSize: Qt.size(345, 96)
            source: "lib/images/logoVossca_layer.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Image {
            x: 58.521
            y: 329.34
            id: operator_label
            source: "lib/images/operator_label.svg"
        }
        Image {
            x: 1812.943
            y: 1025
            sourceSize.height: 23
            sourceSize.width: 70
            id: mcd_label
            source: "lib/images/by_mcd.svg"
        }
        Date {
            anchors.horizontalCenter: parent.horizontalCenter
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
        JSONListModel {
            id: usersModel
            source: "http://192.168.142.226/api/get_pass_operators.json"
            query: "$.users[*]"
        }

        ListView {
            id: listView
            x: 52.218
            y: 403.849
            width: 1838.381
            height: 325.152
            orientation: ListView.Horizontal
            preferredHighlightBegin: listView.width / 2 - 210.724 / 2
            preferredHighlightEnd: listView.width / 2 + 210.724 / 2
            focus: true
            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveVelocity: 1000
            model: usersModel.model
            add: Transition {
                NumberAnimation {
                    properties: "x"
                    duration: 600
                    easing.type: Easing.OutBack
                }
            }

            delegate: Rectangle {
                id: itemDelegate
                width: 210.724
                height: 325.152
                color: "transparent"
                Item {
                    width: 193
                    height: 193
                    x: 7.144
                    y: 14.513
                    Image {
                        id: bg
                        source: "lib/images/profile_mask.svg"
                        sourceSize: Qt.size(parent.width, parent.height)
                        opacity: 0.05
                    }
                    Image {
                        id: pic
                        anchors.centerIn: parent.Center
                        sourceSize: Qt.size(bg.width, bg.height)
                        source: "http://192.168.142.226/" + photo
                        smooth: true
                        visible: false
                    }
                    Image {
                        id: mask
                        source: "lib/images/profile_mask.svg"
                        sourceSize: Qt.size(parent.width, parent.height)
                        smooth: true
                        visible: false
                    }
                    OpacityMask {
                        anchors.fill: pic
                        source: pic
                        maskSource: mask
                    }
                }
                MouseArea {
                    id: idMouseAreaDown
                    anchors.fill: parent
                    onClicked: {
                        listView.currentIndex = index
                    }
                }
                Rectangle {
                    y: 221.651
                    width: parent.width
                    height: 103
                    color: "transparent"
                    Rectangle {
                        width: parent.width
                        height: parent.height
                        x: 0
                        y: 0
                        color: "transparent"
                        RadialGradient {
                            anchors.fill: parent
                            gradient: Gradient {
                                GradientStop {
                                    position: 0.5
                                    color: "#898989"
                                }
                                GradientStop {
                                    position: 0.0
                                    color: "#DDDDDD"
                                }
                            }
                        }
                        opacity: 0.1
                        border.color: "#F2F2F2"
                        border.width: 2
                    }

                    visible: index == listView.currentIndex
                    WidgetLabelUI {
                        anchors.left: parent.left
                        anchors.leftMargin: 9
                        anchors.top: parent.top
                        anchors.topMargin: 7
                        text: first_name
                        color: "#009EDF"
                    }
                    TextField {
                        id: searchField
                        x: 6
                        y: 37
                        width: 199
                        height: 29
                        placeholderText: qsTr("password...")
                        echoMode: TextInput.Password
                        style: TextFieldStyle {
                            textColor: "#666666"
                            background: Rectangle {
                                color: "black"
                                implicitWidth: 277
                                implicitHeight: 35
                                opacity: 0.2
                            }
                            selectionColor: "white"
                            selectedTextColor: "black"
                            placeholderTextColor: "#6D6D77"
                        }
                        font.family: "Avenir"
                        font.pixelSize: 12
                    }
                    MouseArea {
                        width: 78
                        height: 14
                        anchors.right: parent.right
                        anchors.rightMargin: 9
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        onClicked: {
                            var comView = Qt.createComponent("lib/MainMenu.qml")
                            window.push({
                                            item: comView,
                                            properties: {
                                                window: window,
                                                imagePath: "http://192.168.142.226/" + photo,
                                                name: full_name
                                            }
                                        })
                        }
                        Rectangle {
                            anchors.fill: parent
                            opacity: 0
                        }

                        Image {
                            width: 17
                            height: 14
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.bottomMargin: 6
                            id: login_arrow
                            source: "lib/images/arrows/login_arrow.svg"
                        }
                        WidgetLabelUI {
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            text: "LOGIN"
                            color: "#1EBB9C"
                            font.pixelSize: 18
                        }
                    }
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
                    value: 0.6
                    when: !(index == listView.currentIndex)
                }
                Binding {
                    target: itemDelegate
                    property: "y"
                    value: 15
                    when: !(index == listView.currentIndex)
                }
            }
        }
        Item {
            id: outlineContainer
            anchors.fill: parent
            // Top line
            WidgetLineWithInwardArrowsHorizontal {
                x: 351.5
                y: 127
                length: 1468
            }
            // Bottom Line
            WidgetLineWithInwardArrowsHorizontal {
                x: 105.414
                y: 1027.655
                length: 1469.46
            }
            // Left Line
            WidgetLineWithInwardArrowsVertical {
                x: 24.636
                y: 330.153
                length: 688.776
            }
            // Right Line
            WidgetLineWithInwardArrowsVertical {
                x: 1904.544
                y: 146.807
                length: 672.693
            }
            // Top Left Corner Lines
            // * 1
            WidgetLineWithInwardArrowsHorizontal {
                x: 253.497
                y: 168.108
                length: 114.598
            }
            // * 2
            WidgetLineWithInwardArrowsHorizontal {
                x: 196.198
                y: 217.355
                length: 114.598
            }
            // * 3
            WidgetLineWithInwardArrowsHorizontal {
                x: 131.701
                y: 266.602
                length: 114.598
            }
            // * 4
            WidgetLineWithInwardArrowsHorizontal {
                x: 34.636
                y: 315.849
                length: 114.598
            }
            // Bottom Right Corner Lines
            // * 1
            WidgetLineWithInwardArrowsHorizontal {
                x: 1788.398
                y: 840.06
                length: 114.598
            }
            // * 2
            WidgetLineWithInwardArrowsHorizontal {
                x: 1731.1
                y: 889.308
                length: 114.598
            }
            // * 3
            WidgetLineWithInwardArrowsHorizontal {
                x: 1666.603
                y: 938.555
                length: 114.598
            }
            // * 4
            WidgetLineWithInwardArrowsHorizontal {
                x: 1569.537
                y: 987.802
                length: 114.598
            }
        }
    }
}
