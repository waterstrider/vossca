import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Rectangle {
    id: container
    property var context
    property var window
    property var currentDate: new Date()
    property int month: currentDate.getMonth()
    property int year: currentDate.getFullYear()
    property var monthList: ["JANUARY", "FEBRUARY", "MARCH", "APRIL","MAY", "JUNE", "JULY", "AUGUST",
        "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];

    width: 1920; height: 1080
    color: "black"

    Component.onCompleted: {
        console.log("ReplayCalendarView loaded");
    }

    Component.onDestruction: {
        console.log("ReplayCalendarView to be destructed")
    }

    ListModel {
        id: listYear
        property int initialIndex: 10
        Component.onCompleted: {
            var currentYear = currentDate.getFullYear();
            for(var y = currentYear-10; y <= currentYear+10; y++)
                listYear.append({"value": y, "text": y});
        }
    }

    ListModel {
        id: listMonthYear
        property int initialIndex: 120+month
        Component.onCompleted: {
            var currentYear = currentDate.getFullYear();
            for(var y = currentYear-10; y <= currentYear+10; y++) {
                for(var m = 0; m < 12; m++) {
                    listMonthYear.append({"value":{"month":m, "year":y}, "text":(monthList[m].substr(0,3) + " " + y)});
                }
            }
        }
    }

    Image {
        id: imgBackground
        x: 0; y: 0
        source: "images/bg1.png"
    }

    WidgetLoginInfo {
        id: userInfo
        x: 10; y: 50
        context: container.context
    }

    Column {
        x: 10; y: 382
        spacing: 10
        Repeater {
            model: monthList
            WidgetButtonItem {
                width: 290; height: 45
                labelLeft: index+1
                labelLeftMargin: 20
                borderColor: "#009DCC"
                bgColorPressed: "#009DCC"
                textColor: "#FFFFFF"
                label: modelData
                onClicked: {
                    container.month = index;
                    selectionMonthYear.selectedIndex = 12*(container.year-currentDate.getFullYear()+10)+container.month;
                    tabView.currentIndex = 1;
                }
            }
        }
    }

    WidgetSelectLeftRight {
        id: selectionYear
        x: 1570; y: 82
        width: 160; height: 50
        //borderColor: "transparent"
        model: listYear
        selectedIndex: listYear.initialIndex
        visible: (tabView.currentIndex == 0)
        onSelectedItemChanged: {
            if(container.year != selectedItem) {
                container.month = 0;
                container.year = selectedItem;
                selectionMonthYear.selectedIndex = 12*(container.year-currentDate.getFullYear()+10)+container.month;
            }
        }
    }

    WidgetSelectLeftRight {
        id: selectionMonthYear
        x: 1570; y: 82
        width: 240; height: 50
        //borderColor: "transparent"
        model: listMonthYear
        selectedIndex: listMonthYear.initialIndex
        visible: (tabView.currentIndex == 1)
        onSelectedItemChanged: {
            if(container.month != selectedItem.month) {
                container.month = selectedItem.month;
                if(container.year != selectedItem.year) {
                    container.year = selectedItem.year;
                    selectionYear.selectedIndex = container.year-currentDate.getFullYear()+10;
                }
            }
        }
    }

    TabView {
        id: tabView
        x: 365; y: 82
        width: 1500; height: 960
        style: TabViewStyle {
                tabOverlap: -20
                tab: Rectangle {
                    color: styleData.selected?"#009DCC":"transparent"
                    border.color:  "white"
                    implicitWidth: 240
                    implicitHeight: 50
                    WidgetLabelUI {
                        id: text
                        anchors.centerIn: parent
                        font.pixelSize: 20
                        text: styleData.title
                        color: "white"
                    }
                }
                frame: Rectangle { color: "transparent"; anchors.fill: parent }
            }

        Tab {
            title: "Year"
            WidgetCalendarYear {
                id: widgetCalendarYear
                anchors.centerIn: parent
                year: container.year
                onMonthClicked: {
                    container.month = clickedMonth;
                    selectionMonthYear.selectedIndex = 12*(container.year-currentDate.getFullYear()+10)+container.month;
                    tabView.currentIndex = 1;
                }
                onDayClicked: {
                    var sessionList = context.getDbList(clickedDate.getFullYear(),clickedDate.getMonth(),clickedDate.getDate());
                    if(sessionList.length > 0) {
                        var comp = Qt.createComponent("ReplayPlayerView.qml");
                        container.Stack.view.push({item: comp, properties:{"context":context,
                                                          "window":window,
                                                          "sessionName":null,
                                                          "date":clickedDate}});
                    }
                }
            }
        }
        Tab {
            title: "Month"
            WidgetCalendarMonth {
                id: widgetCalendarMonth
                x: 0; y: 30
                month: container.month
                year: container.year
                model: context.dbListByDate
                onDayClicked: {
                    var sessionList = context.getDbList(clickedDate.getFullYear(),clickedDate.getMonth(),clickedDate.getDate());
                    if(sessionList.length > 0) {
                        var comp = Qt.createComponent("ReplayPlayerView.qml");
                        container.Stack.view.push({item: comp, properties:{"context":context,
                                                          "window":window,
                                                          "sessionName":null,
                                                          "date":clickedDate}});
                    }
                }
                onItemClicked: {
                    var comp = Qt.createComponent("ReplayPlayerView.qml");
                    container.Stack.view.push({item: comp, properties:{"context":context,
                                                      "window":window,
                                                      "sessionName":clickedItem,
                                                      "date":clickedDate}});
                }
            }
        }
    }
}
