import QtQuick 2.0
import QtQuick.Window 2.1
import "./lib"

Rectangle {
    id: container

    Component.onCompleted: {
        console.log("Main window loaded");
        rootView.visibilityChanged.connect(adjustFullScreen);
    }
    Component.onDestruction: {
        console.log("Main window to be destructed");
    }
    function adjustFullScreen() {
        if(rootView.visibility == Window.Maximized)
            rootView.fullScreen = true;
    }

    GlobalContext {
        id: globalContext
    }

    width: 1920; height: 1080
    color: "black"

    Rectangle {
        id: bgView
        anchors.fill: parent
        scale: Math.min(width/contentView.width,height/contentView.height)
        color: "black"
        Rectangle {
            id: contentView
            width: 1920; height: 1080
            anchors.centerIn: parent

            Image {
                id: imageBackground
                source: "lib/images/bg1.png"
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

            Item {
                property var currentDate: new Date()
                id: mainMenu
                width: 1920; height: 1080

                Image {
                    id: imageLogoVossca
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 120
                    source: "lib/images/logo1.png"
                }

                Image {
                    id: imageMainMenu
                    anchors.centerIn: parent
                    source: "lib/images/logoMainMenu.png"
                    transformOrigin: Item.Center
//                    NumberAnimation on rotation {
//                        from: 0; to: 360
//                        loops: Animation.Infinite
//                        duration: 10000
//                        running: true
//                    }

                    MouseArea {
                        x: 40; y: 140
                        width: 60; height: 135
                        onClicked: {
                            var comChildWindow = Qt.createComponent("lib/NavigatorWindow.qml");
                            var win = comChildWindow.createObject(container);
                            var comView = Qt.createComponent("lib/ReplayCalendarView.qml");
                            win.stack.push({item: comView, properties:{"context":globalContext,
                                                              "window":win}});
                            if(rootView.fullScreen)
                                win.showFullScreen()
                            else
                                win.show();
                        }
                    }

                    MouseArea {
                        x: 288; y: 179
                        width: 60; height: 122
                        onClicked: {
                            var comChildWindow = Qt.createComponent("lib/NavigatorWindow.qml");
                            var win = comChildWindow.createObject(container);
                            var comView = Qt.createComponent("lib/LiveView.qml");
                            win.stack.push({item: comView, properties:{"context":globalContext,
                                                              "window":win}});
                            if(rootView.fullScreen)
                                win.showFullScreen()
                            else
                                win.show();
                        }
                    }
                }

            //    WidgetLoginInfo {

            //    }


            }
        }
    }
}
