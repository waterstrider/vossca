import QtQuick 2.3

WidgetButtonCornered {

    signal monthClicked(var clickedMonth)
    signal dayClicked(var clickedDate)
    property int year: new Date().getFullYear()
    property var monthNames: ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
    property int month: new Date().getMonth()
    width: 307
    height: 172

    //    bgColor: "black"
    function incrementMonth() {
        month += 1
        if (month > 11) {
            year += 1
            month = 0
        }
    }

    function decrementMonth() {
        month -= 1
        if (month < 0) {
            year -= 1
            month = 11
        }
    }
    Rectangle {
        width: 245
        height: parent.height - 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        color: "transparent"
        WidgetLabelUI {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 5
            anchors.top: parent.top
            height: 30
            text: monthNames[month]
            color: "white"
            font.pixelSize: 18
            horizontalAlignment: Text.AlignLeft
        }
        WidgetLabelUI {
            anchors.right: parent.right
            anchors.rightMargin: 6
            anchors.topMargin: 5
            anchors.top: parent.top
            height: 30
            text: year
            color: "white"
            font.pixelSize: 18
            horizontalAlignment: Text.AlignRight
        }

        Row {
            x: 0
            y: 40
            spacing: 0
            Repeater {
                model: ["S  ", "M  ", "T  ", "W  ", "T  ", "F  ", "S  "]
                WidgetLabelUI {
                    width: 35
                    height: 17
                    horizontalAlignment: Text.AlignRight
                    color: (index == 0) ? "red" : "white"
                    text: modelData
                    font.pixelSize: 13
                }
            }
        }

        Grid {
            x: 0
            y: 60

            columns: 7
            rowSpacing: 1
            columnSpacing: 0
            Repeater {
                model: 42
                WidgetButton {
                    property var date: getDateForCalMonth(year, month, index)
                    Component.onCompleted: {
                        if (label) {
                            if (date.toDateString(
                                        ) == (new Date).toDateString()) {
                                isOn = true
                            }
                        }
                    }
                    width: 35
                    height: 16

                    label: (date.getMonth() == month) ? date.getDate(
                                                            ) + "  " : ""
                    textColor: (index % 7 == 0) ? "red" : "white"
                    labelAlignment: Text.AlignRight
                    fontSize: 13
                    borderColor: "transparent"
                    enabled: (date.getMonth() == month)
                    onIsOnChanged: {
                        if (label) {
                            if (date.toDateString(
                                        ) == (new Date).toDateString()) {
                                isOn = true
                            }
                        }
                    }
                    onClicked: dayClicked(date)
                }
            }
        }
    }
    onClicked: monthClicked(month)
    function getDateForCalMonth(year, month, i) {
        var d = new Date(year, month, 1)
        d.setDate(d.getDate() - d.getDay() + i)
        return d
    }

    WidgetScrollArrowLeft {
        id: leftArrow

        width: 17.25
        height: 35.75
        anchors.left: parent.left
        anchors.leftMargin: 6.524
        anchors.verticalCenter: parent.verticalCenter
        onPressed: decrementMonth()
    }

    WidgetScrollArrowRight {
        id: rightArrow

        width: 17.25
        height: 35.75
        anchors.right: parent.right
        anchors.rightMargin: 6.524
        anchors.verticalCenter: parent.verticalCenter
        onPressed: incrementMonth()
    }
}
