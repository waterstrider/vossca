import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.1

Rectangle {
    id: imageMainMenu
    property var window
    property string imagePath
    property string name
    property bool running: true
    width: 364.417
    height: 364.417
    color: "transparent"

    Behavior on width {
        NumberAnimation {
            duration: 1000
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 1000
        }
    }
    Rectangle {
        id: buttonMainMenu
        width: 320.489 / 364.417 * parent.width
        height: 320.489 / 364.417 * parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        onRotationChanged: {
            if (!imageMainMenu.running) {
                buttonMainMenuAnimation.duration = 10000
                if (rotation < 1) {
                    buttonMainMenuAnimation.running = false
                }
            }
        }

        NumberAnimation on rotation {
            id: buttonMainMenuAnimation
            from: 360
            to: 0
            loops: Animation.Infinite
            duration: 70000
        }
        Image {
            property real offset: -21.5
            property real margin: 6.4
            id: countdown
            source: "images/menu/countdown_60.svg"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: margin / 364.417 * imageMainMenu.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: offset / 364.417 * imageMainMenu.width
            sourceSize: Qt.size(224.996 / 364.417 * imageMainMenu.width,
                                98.875 / 364.417 * imageMainMenu.height)
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var comChildWindow = Qt.createComponent(
                                "NavigatorWindow.qml")
                    var win = comChildWindow.createObject()
                    var comView = Qt.createComponent("CountDownWebView.qml")
                    win.stack.push({
                                       item: comView,
                                       properties: {
                                           context: globalContext,
                                           window: win
                                       }
                                   })
                    if (rootView.fullScreen)
                        win.showFullScreen()
                    else
                        win.show()
                }
            }
        }
        Image {
            property real topMargin: 7.75
            property real rightMargin: 9.75
            id: mission_control
            sourceSize: Qt.size(208.607 / 364.417 * imageMainMenu.width,
                                134.438 / 364.417 * imageMainMenu.height)
            source: "images/menu/mission_control_60.svg"
            anchors.top: parent.top
            anchors.topMargin: topMargin / 364.417 * imageMainMenu.width
            anchors.right: parent.right
            anchors.rightMargin: rightMargin / 364.417 * imageMainMenu.width
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var comChildWindow = Qt.createComponent(
                                "NavigatorWindow.qml")
                    //                            var win = comChildWindow.createObject(container);
                    var win = comChildWindow.createObject()
                    var comView = Qt.createComponent(
                                "TentativeCalendarView.qml")
                    var comp = Qt.createComponent("ActivityPlanSchedule.qml")
                    win.stack.push([{
                                        item: comView,
                                        properties: {
                                            context: globalContext,
                                            window: win
                                        }
                                    }, {
                                        item: comp,
                                        properties: {
                                            window: win,
                                            date: new Date
                                        }
                                    }])
                    if (rootView.fullScreen)
                        win.showFullScreen()
                    else
                        win.show()
                }
            }
        }
        Image {
            property real offset: 4.8
            property real margin: 5.2
            id: replay
            sourceSize: Qt.size(58.692 / 364.417 * imageMainMenu.width,
                                157.021 / 364.417 * imageMainMenu.height)
            source: "images/menu/replay_60.svg"
            anchors.left: parent.left
            anchors.leftMargin: margin / 364.417 * imageMainMenu.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: offset / 364.417 * imageMainMenu.width
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var comChildWindow = Qt.createComponent(
                                "NavigatorWindow.qml")
                    //                            var win = comChildWindow.createObject(container);
                    var win = comChildWindow.createObject()
                    var comView = Qt.createComponent("ReplayCalendarView.qml")
                    win.stack.push({
                                       item: comView,
                                       properties: {
                                           context: globalContext,
                                           window: win,
                                           imagePath: container.imagePath,
                                           name: container.name
                                       }
                                   })
                    if (rootView.fullScreen)
                        win.showFullScreen()
                    else
                        win.show()
                }
            }
        }
        Image {
            property real topMargin: 15.1
            property real leftMargin: 22.30
            id: report
            sourceSize: Qt.size(105.242 / 364.417 * imageMainMenu.width,
                                98.786 / 364.417 * imageMainMenu.height)
            source: "images/menu/report_60.svg"
            anchors.left: parent.left
            anchors.leftMargin: leftMargin / 364.417 * imageMainMenu.width
            anchors.top: parent.top
            anchors.topMargin: topMargin / 364.417 * imageMainMenu.height
        }
        Image {
            property real margin: 7.0
            property real offset: 44.1
            id: skeletal_sys
            sourceSize: Qt.size(93.487 / 364.417 * imageMainMenu.width,
                                173.09 / 364.417 * imageMainMenu.height)
            source: "images/menu/skeletal_sys_60.svg"
            anchors.right: parent.right
            anchors.rightMargin: margin / 364.417 * imageMainMenu.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: offset / 364.417 * imageMainMenu.width
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var comChildWindow = Qt.createComponent(
                                "NavigatorWindow.qml")
                    //                            var win = comChildWindow.createObject(container);
                    var win = comChildWindow.createObject()
                    var comView = Qt.createComponent("LiveView.qml")
                    win.stack.push({
                                       item: comView,
                                       properties: {
                                           context: globalContext,
                                           window: win
                                       }
                                   })
                    if (rootView.fullScreen)
                        win.showFullScreen()
                    else
                        win.show()
                }
            }
        }
    }
    Image {
        id: white_ring_outer
        source: "images/rings/white_ring_outer.svg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        sourceSize: Qt.size(parent.width, parent.height)
        visible: false
        smooth: true
    }
    Rectangle {
        color: "transparent"
        anchors.fill: white_ring_outer
        Glow {
            anchors.fill: parent
            radius: 5
            spread: 0.5
            samples: 16
            color: "#FCF1EF"
            source: white_ring_outer
        }
        NumberAnimation on rotation {
            from: 360
            to: 0
            loops: Animation.Infinite
            duration: 25000
        }
        NumberAnimation on opacity {
            id: white_ring_outer_fade_out
            running: false
            from: 1
            to: 0
            duration: 1000
        }
        NumberAnimation on opacity {
            id: white_ring_outer_fade_in
            running: false
            from: 0
            to: 1
            duration: 1000
        }
    }
    Image {
        id: blue_ring_outer
        source: "images/rings/blue_ring_outer.svg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        sourceSize: Qt.size(334.982 / 364.417 * parent.width,
                            334.982 / 364.417 * parent.height)
        smooth: true
        visible: false
    }
    Rectangle {
        color: "transparent"
        anchors.fill: blue_ring_outer
        Glow {
            anchors.fill: parent
            radius: 5
            spread: 0.5
            samples: 16
            color: "#009EDF"
            source: blue_ring_outer
        }
        NumberAnimation on rotation {
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 50000
        }
        NumberAnimation on opacity {
            id: blue_ring_outer_fade_out
            running: false
            from: 1
            to: 0
            duration: 1000
        }
        NumberAnimation on opacity {
            id: blue_ring_outer_fade_in
            running: false
            from: 0
            to: 1
            duration: 1000
        }
    }
    Image {
        id: blue_ring_middle
        source: "images/rings/blue_ring_middle.svg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        sourceSize: Qt.size(200.413 / 364.417 * parent.width,
                            200.413 / 364.417 * parent.height)
        visible: false
        smooth: true
    }
    Rectangle {
        color: "transparent"
        anchors.fill: blue_ring_middle
        Glow {
            anchors.fill: parent
            radius: 5
            spread: 0.5
            samples: 16
            color: "#009EDF"
            source: blue_ring_middle
        }
        NumberAnimation on rotation {
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 20000
        }
        NumberAnimation on opacity {
            id: blue_ring_middle_fade_out
            running: false
            from: 1
            to: 0
            duration: 1000
        }
        NumberAnimation on opacity {
            id: blue_ring_middle_fade_in
            running: false
            from: 0
            to: 1
            duration: 1000
        }
    }
    Image {
        id: white_ring_inner
        source: "images/rings/white_ring_inner.svg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        sourceSize: Qt.size(180.631 / 364.417 * parent.width,
                            180.631 / 364.417 * parent.height)
        smooth: true
        visible: false
    }
    Rectangle {
        color: "transparent"
        anchors.fill: white_ring_inner
        Glow {
            anchors.fill: parent
            radius: 5
            spread: 0.5
            samples: 16
            color: "#FCF1EF"
            source: white_ring_inner
        }
        NumberAnimation on rotation {
            from: 360
            to: 0
            loops: Animation.Infinite
            duration: 50000
        }
        NumberAnimation on opacity {
            id: white_ring_inner_fade_out
            running: false
            from: 1
            to: 0
            duration: 1000
        }
        NumberAnimation on opacity {
            id: white_ring_inner_fade_in
            running: false
            from: 0
            to: 1
            duration: 1000
        }
    }
    Image {
        id: blue_ring_inner
        fillMode: Image.Stretch
        source: "images/rings/blue_ring_inner.svg"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        sourceSize: Qt.size(137.996 / 364.417 * parent.width,
                            137.996 / 364.417 * parent.height)
        visible: false
        smooth: true
    }
    Rectangle {
        color: "transparent"
        anchors.fill: blue_ring_inner
        Glow {
            anchors.fill: parent
            radius: 5
            spread: 0.5
            samples: 16
            color: "#009EDF"
            source: blue_ring_inner
        }
        NumberAnimation on rotation {
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 10000
        }
        NumberAnimation on opacity {
            id: blue_ring_inner_fade_out
            running: false
            from: 1
            to: 0
            duration: 1000
        }
        NumberAnimation on opacity {
            id: blue_ring_inner_fade_in
            running: false
            from: 0
            to: 1
            duration: 1000
        }
    }
    Rectangle {
        anchors.fill: white_ring_inner
        radius: width * 0.5
        opacity: 0
        MouseArea {
            property bool expand: false
            id: center
            anchors.fill: parent
            onClicked: {
                if (!center.expand) {
                    white_ring_inner_fade_out.start()
                    white_ring_outer_fade_out.start()
                    blue_ring_inner_fade_out.start()
                    blue_ring_middle_fade_out.start()
                    blue_ring_outer_fade_out.start()
                    center.expand = true

                    imageMainMenu.width = 700
                    imageMainMenu.height = 700

                    countdown.margin = 0
                    countdown.offset = -23.5

                    mission_control.rightMargin = 5.5
                    mission_control.topMargin = 0

                    replay.margin = 0
                    replay.offset = 4.5

                    report.leftMargin = 20
                    report.topMargin = 9.5

                    skeletal_sys.margin = 0.75
                    skeletal_sys.offset = 45.5

                    imageMainMenu.running = false
                } else {
                    white_ring_inner_fade_in.start()
                    white_ring_outer_fade_in.start()
                    blue_ring_inner_fade_in.start()
                    blue_ring_middle_fade_in.start()
                    blue_ring_outer_fade_in.start()
                    center.expand = false

                    imageMainMenu.width = 364.417
                    imageMainMenu.height = 364.417

                    countdown.margin = 5
                    countdown.offset = -20.5

                    mission_control.rightMargin = 8.75
                    mission_control.topMargin = 9.15

                    replay.margin = 6.2
                    replay.offset = 6.2

                    report.leftMargin = 23.30
                    report.topMargin = 16.5

                    skeletal_sys.margin = 6.0
                    skeletal_sys.offset = 45.5

                    buttonMainMenuAnimation.running = true
                    imageMainMenu.running = true
                }
            }
        }
    }
}
