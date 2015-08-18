
// /////////////////////////////////////////////////////////////////////////////////////////
// Widget Name: WidgetCountdownTimer
// /////////////////////////////////////////////////////////////////////////////////////////
// Historical revue:
// -----------------------------------------------------------------------------------------
// Version  |   Date        |   Author      |   Comments
//  v1.0    |   16/07/15    |   S. Chanate  |   Creation (Widget isn't design to be resizable yet)
// -----------------------------------------------------------------------------------------
// /////////////////////////////////////////////////////////////////////////////////////////
// Objective of the widget:
// This widget aims to create a countdown timer. It will display the time different between
// the machine's UTC time to the "alarmDateTime". "alarmDateTime" string should match
// RFC2822 or ISO 8601 date format.
// /////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.0

Rectangle {
    id: countdownTimer

    //UTC Time to be alarmed
    property string alarmDateTime

    //Remaining Time
    property int remainingHr
    property int remainingMin
    property int remainingSec

    property color segmentColor: "#FFFFFF"
    property color segmentOffColor: "#202020"
    property real segmentWidth: 3

    signal timeOut

    function updateRemainingTime() {
        var currentDateTime = new Date
        var alarmDateTime = new Date(Date.parse(countdownTimer.alarmDateTime))

        var timeDifference = alarmDateTime - currentDateTime
        var remainingDateTime = new Date(timeDifference)

        remainingHr = remainingDateTime.getUTCHours()
        remainingMin = remainingDateTime.getUTCMinutes()
        remainingSec = remainingDateTime.getUTCSeconds()

        timeOut()
    }

    width: 205
    height: 62

    color: "transparent"

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: countdownTimer.updateRemainingTime()
    }

    LCDDisplay {
        id: hoursDigit

        width: 54

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        number: remainingHr
        segmentColorD: segmentColor
        segmentOffColorD: segmentOffColor
        segmentWidthD: segmentWidth
    }

    TimeSep {
        id: hrMinSep

        width: 10

        anchors.left: hoursDigit.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        seperatorColor: "#FFFFFF"
    }

    LCDDisplay {
        id: minuteDigit

        width: 54

        anchors.left: hrMinSep.right
        anchors.verticalCenter: parent.verticalCenter

        number: remainingMin
        segmentColorD: segmentColor
        segmentOffColorD: segmentOffColor
        segmentWidthD: segmentWidth
    }

    TimeSep {
        id: minSecSep

        width: 10

        anchors.left: minuteDigit.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        seperatorColor: "#FFFFFF"
    }

    LCDDisplay {
        id: secondDigit

        width: 54

        anchors.left: minSecSep.right
        anchors.verticalCenter: parent.verticalCenter

        number: remainingSec
        segmentColorD: segmentColor
        segmentOffColorD: segmentOffColor
        segmentWidthD: segmentWidth
    }
}
