import QtQuick 2.0

Rectangle {
    property var date: new Date
    property var monthNames: ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
    id: container
    width: 560
    height: 54
    color: "transparent"
    Image {
        id: background
        width: parent.width
        height: parent.height
        source: "images/date_bg.svg"
    }

    WidgetLabelUI {
        id: label
        text: getDayOfWeek(
                  container.date.getUTCDay(
                      )) + ", " + container.monthNames[container.date.getUTCMonth(
                                                           )] + " " + container.date.getUTCDate(
                  ) + ", " + container.date.getUTCFullYear()
        font.pixelSize: 35
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    function getDayOfWeek(Day) {
        var weekday = new Array(7)
        weekday[0] = "SUN"
        weekday[1] = "MON"
        weekday[2] = "TUES"
        weekday[3] = "WEDNES"
        weekday[4] = "THURS"
        weekday[5] = "FRI"
        weekday[6] = "SATUR"
        return weekday[Day] + "DAY"
    }
}
