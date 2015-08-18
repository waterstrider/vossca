import QtQuick 2.3

Item {
    property string _name: "N - 1"
    property int _value_1: 23
    property string _value_2: "TELECOMMAND"
    property string _value_3: "RC.TM.RCQMONSTA"
    property bool _behavior: false
    Text {
        x: 0
        y: 0
        width: 60
        color: "#DDDDDD"
        font.family: "Gill Sans MT"
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        text: _name
    }
    Image {
        x: 85
        y: 3
        source: "images/cop_telecom.png"
        scale: 1.1
    }
    Text {
        color: "#DDDDDD"
        x: 80
        y: 0
        width: 44
        height: 15
        font.family: "Gill Sans MT"
        font.pixelSize: 12
        text: _value_1
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        color: "#DDDDDD"
        x: 172
        y: 0
        width: 88
        height: 15
        font.family: "Gill Sans MT"
        font.pixelSize: 12
        text: _value_2
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        color: "#DDDDDD"
        x: 313
        y: 0
        width: 112
        height: 15
        font.family: "Gill Sans MT"
        font.pixelSize: 12
        text: _value_3
        horizontalAlignment: Text.AlignHCenter
    }
}
