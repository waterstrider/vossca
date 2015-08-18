import QtQuick 2.3
import QtQuick.Window 2.1

Rectangle {
    id: container
    property var window
    property string imagePath
    property string name
    Component.onDestruction: {
        console.log("Main window to be destructed")
    }

    GlobalContext {
        id: globalContext
    }

    width: 1920
    height: 1080
    color: "black"

    Rectangle {
        id: bgView
        anchors.fill: parent
        scale: Math.min(width / contentView.width, height / contentView.height)
        color: "black"
        Rectangle {
            id: contentView
            width: 1920
            height: 1080
            anchors.centerIn: parent

            Image {
                id: imageBackground
                source: "images/bg1.png"
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

            Item {
                property var currentDate: new Date()
                id: mainMenu
                width: 1920
                height: 1080

                Image {
                    sourceSize: Qt.size(345, 96)
                    id: imageLogoVossca
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 130
                    source: "images/logoVossca_layer.png"
                }
                ArcMainMenu {
                    imagePath: container.imagePath
                    name: container.name
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 30
                }
            }
            OperatorSingle {
                id: operatorSingle
                x: 18
                y: 18
                name: container.name
                imagePath: container.imagePath
                WidgetButton {
                    id: buttonBack
                    x: operatorSingle.width - width - 10
                    y: operatorSingle.height - height - 10
                    width: 90
                    height: 18
                    label: "LOGOUT"
                    visible: (window.depth > 1)
                    onClicked: window.pop()
                }
            }

            Item {
                id: outlineContainer
                anchors.fill: parent
                // Top line
                WidgetLineWithInwardArrowsHorizontal {
                    x: 330.5
                    y: 127
                    length: 1483
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
                    y: 255.153
                    length: 763.776
                }
                // Right Line
                WidgetLineWithInwardArrowsVertical {
                    x: 1904.544
                    y: 146.807
                    length: 672.693
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
}
