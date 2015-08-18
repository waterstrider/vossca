import QtQuick 2.3
import QtQuick.Window 2.1
import QtQuick.Controls 1.0

Window {
    property alias initialView: stackView.initialItem
    property alias stack: stackView
    property alias bgColor: bgView.color
    property real scaleFactor: Math.min(window.width / rootView.width,
                                        window.height / rootView.height)
    id: window
    width: 1920
    height: 1080
    color: "black"

    Component.onCompleted: {
        console.log("Navigator window loaded")
    }
    Component.onDestruction: {
        console.log("Navigator window to be destructed")
    }

    onVisibilityChanged: {
        if (visibility == Window.Maximized)
            window.visibility = Window.FullScreen
    }

    Rectangle {
        id: bgView
        anchors.fill: parent
        scale: scaleFactor
        color: "black"
        Item {
            id: rootView

            width: 1920
            height: 1080
            anchors.centerIn: parent

            WidgetWindowControl {
                id: windowControl
                z: 90
                anchors.top: parent.top
                anchors.right: parent.right
                visible: (window.visibility == Window.FullScreen)
                onMinimize: window.visibility = Window.Minimized
                onToggle: {
                    if (window.visibility != Window.FullScreen)
                        window.visibility = Window.FullScreen
                    else
                        window.visibility = Window.AutomaticVisibility
                }
                onClose: window.close()
            }

            WidgetButton {
                id: buttonBack
                x: 10
                y: 10
                z: 90
                width: 60
                height: 18
                label: "Back"
                visible: (stackView.depth > 1)
                onClicked: stackView.pop()
            }

            StackView {
                id: stackView
                anchors.fill: parent
            }
        }
    }
}
