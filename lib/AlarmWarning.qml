import QtQuick 2.0
import com.terma.TM 1.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

Rectangle {
    width: 200
    height: 222
    color: "transparent"
    Image {
        id: bg
        anchors.fill: parent
        source: "images/ool_monitor_bg.svg"
    }

    WidgetLabelUI {
        id: alarmWarnig
        anchors.topMargin: 4
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.left: parent.left
        text: "OUT OF LIMITS MONITOR ALARM / WARNING"
        font.pixelSize: 14
        font.family: "Avenir"
        color: "#009CDD"
    }
    Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 30
        width: 722.506
        height: 23.666
        color: "#0099CC"
        radius: 5
        WidgetLabelUI {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            text: "Acknowledged    /    Type    /    ID    /    Time    /    Message"
            font.pixelSize: 12
            font.family: "Avenir"
        }
    }

    ListView {
        id: listView
        width: 744
        height: 134.332
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 57
        spacing: 3.334
        model: alarms
        clip: true
        delegate: Rectangle {
            id: entry
            signal ackAlarmRow(int idx)
            width: 722.506
            height: 23.666
            radius: 5
            color: {
                if (type)
                    "#E06522"
                else
                    "#DB1C24"
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: acknowledged + " / " + (type ? "WARNING" : "ALARM") + " / "
                                                    + id + " / " + time + " / " + message
                font.pixelSize: 12
                font.family: "Avenir"
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mouse.accepted = true
                    console.log("Clicked " + index)
                    entry.ackAlarmRow(index)
                }
            }
            Component.onCompleted: {
                entry.ackAlarmRow.connect(alarms.ackAlarmRow)
            }
        }
    }
    function listProperty(item) {
        console.log(item)
        for (var p in item)
            console.log(p + ":" + item[p])
    }
    WidgetScrollBar {
        flickable: listView
    }
}
