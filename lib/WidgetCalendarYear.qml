import QtQuick 2.0

Item {
    signal monthClicked(var clickedMonth)
    signal dayClicked(var clickedDate)

    id: container
    property int year:2014

    property var monthNames: [ "JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE",
    "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER" ]

    Grid {
        x: 0; y: 40
        columns: 4
        rowSpacing: 25; columnSpacing: 25
        Repeater {
            model: 12
            WidgetButtonCornered {
                property int month: index
                width: 320; height: 270

                WidgetLabelUI {
                    anchors.leftMargin: 30
                    anchors.left: parent.left
                    anchors.topMargin: 5
                    anchors.top: parent.top
                    height: 50
                    text: monthNames[index]
                    color: "white"
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignLeft
                }
                WidgetLabelUI {
                    anchors.rightMargin: 25
                    anchors.right: parent.right
                    anchors.topMargin: 5
                    anchors.top: parent.top
                    height: 50
                    text: year
                    color: "white"
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignRight
                }

                Row {
                    x: 0; y: 55
                    spacing: 0
                    Repeater {
                        model: ["S", "M", "T", "W", "T", "F", "S"]
                        WidgetLabelUI {
                            width: 42; height: 30
                            horizontalAlignment: Text.AlignRight
                            color: (index==0)?"red":"white"
                            text: modelData
                        }
                    }
                }

                Grid {
                    x: 12; y: 85
                    columns: 7
                    rowSpacing: 0; columnSpacing: 12
                    Repeater {
                        model: 42
                        WidgetButton {
                            property var date: getDateForCalMonth(year,month,index)
                            width: 30; height: 30
                            label: (date.getMonth()==month)?date.getDate():""
                            textColor: (index%7==0)?"red":"white"
                            labelAlignment: Text.AlignRight
                            borderColor: "transparent"
                            enabled: (date.getMonth()==month)
                            onClicked: dayClicked(date)
                        }
                    }
                }
                onClicked: monthClicked(month);
            }
        }
    }

    function getDateForCalMonth(year,month,i) {
        var d = new Date(year,month,1);
        d.setDate(d.getDate() - d.getDay() + i);
        return d;
    }





}
