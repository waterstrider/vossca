import QtQuick 2.0

Rectangle {
    id: content
    property var window
    property var date: new Date
    width: 1920
    height: 1080
    color: "black"
    Rectangle {
        id: container
        width: 1920
        height: 1080
        scale: Math.min(content.width / container.width,
                        content.height / container.height)
        anchors.centerIn: parent
        color: "black"
        Image {
            id: imageBackground
            source: "images/bg1.png"
        }
        Operators {
            x: 18
            y: 170
        }

        TestSeqListView {
            id: testSeqListView
            x: 333.928
            y: 88.897
            width: 1307.982
            height: 846.7
            date: content.date
            window: content.window
        }
        Rectangle {
            x: 344.568
            y: 36.516
            width: 312.424
            height: 27.57
            color: "#CC009CDD"
        }
        WidgetLabelUI {
            x: 351.355
            y: 40.431
            id: text
            text: "ACTIVITY PLAN SCHEDULE"
        }
        Date {
            x: 714.5
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
        CalendarMonth {
            x: 1604.5
            y: 131.5
            width: 307
            height: 172
            onMonthClicked: window.stack.pop()
            onDayClicked: testSeqListView.date = clickedDate
        }

        WidgetLineWithInwardArrowsHorizontal {
            id: lineTop
            x: 351.5
            y: 175.667
            length: 1225.66
        }
        WidgetLineWithInwardArrowsHorizontal {
            id: lineBottom
            x: 329.45
            y: 1067.469
            length: 1225.66
        }
        WidgetLineWithInwardArrowsVertical {
            id: lineLeft
            x: 316.625
            y: 378.692
            length: 688.776
        }
        WidgetLineWithInwardArrowsVertical {
            id: lineRight
            x: 1696.555
            y: 365.344
            length: 688.776
        }
        WidgetLineWithInwardArrowsHorizontal {
            id: lineUnderOperator
            x: 18
            y: 369
            length: 296
        }
    }
}
