import QtQuick 2.0

Rectangle {
    color: "transparent"
    Rectangle{
        width:countDownBeforeText.width
        height:countDownBeforeText.height
        color: "blue"
        WidgetLabelUI{
            id:countDownBeforeText
            text:"COUNTDOWN BEFORE"
        }
    }
    Rectangle{
        y:20
        WidgetLabelUI{
            text:"AOS -02:34:05"
        }
    }
}

