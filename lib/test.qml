//import QtQuick 2.3
//Rectangle{
//    onWidthChanged: {
//        var http = new XMLHttpRequest();
//        var url = "http://192.168.142.226/api/get_pass_operation_test_sequences.json";
////        var params = "{ \"date\":\"2015/01/01\" , \"date_station_order\":1 , \"station\":\"siracha\" }";
//        var params = "date=2015%2F06%2F27&date_station_order=2&station=siracha";
//        http.open("GET", url+"?"+params, true);

//        //Send the proper header information along with the request
////        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
////        http.setRequestHeader("Content-length", params.length);
////        http.setRequestHeader("Connection", "close");

//        http.onreadystatechange = function() {//Call a function when the state changes.
//            if(http.readyState == 4) {
////                console.log(http.responseText,url,params);
//                console.log(http.responseText,url+"?"+params);
//            }
//        }
//        http.send(null);
//    }
//}
//import QtQuick 2.3

//Rectangle {
//  id: appWindow

//  ListModel{
//    id: myModel

//    ListElement{ number: "1" }
//    ListElement{ number: "2" }
//    ListElement{ number: "3" }
//    ListElement{ number: "4" }
//    ListElement{ number: "5" }
//    ListElement{ number: "6" }
//    ListElement{ number: "7" }
//    ListElement{ number: "8" }
//  }

//    Rectangle{
//      id: rect
//      anchors.fill: parent

//      PinchArea{
//        id: dndArea
//        anchors.fill: parent

//        property real lastPosition: 0
//        property real moveDelta: 40

//        onPinchStarted: lastPosition = pinch.startPoint2.y

//        onPinchUpdated: {
//          var currentPosition = pinch.point2.y

//          if(currentPosition === pinch.point1.y)
//            return

//          if(lastPosition - currentPosition > moveDelta){
//            lastPosition = currentPosition
//            moveItem(myList.currentIndex - 1)
//          }else if (lastPosition - currentPosition < -moveDelta){
//            lastPosition = currentPosition
//            moveItem(myList.currentIndex + 1)
//          }
//        }

//        function moveItem(targetIndex){
//          if(targetIndex >= 0 && targetIndex < myModel.count){
//            myModel.move(myList.currentIndex, targetIndex, 1)
//          }
//        }
//      }

//      ListView{
//        id: myList
//        anchors.fill: parent

//        model: myModel

//        delegate: Text{
//          width: parent.width
//          text: number
//          font.pointSize: 40
//          horizontalAlignment: Text.AlignHCenter

//          MouseArea{
//            anchors.fill: parent
//            onClicked: myList.currentIndex = index
//          }
//        }

//        highlight: Rectangle{ color: "lightblue" }
//      }
//    }
//  }
//import QtQuick 2.0
//import QtQml.Models 2.1

//GridView {
//    id: root
//    width: 320; height: 480
//    cellWidth: 80; cellHeight: 80

//    displaced: Transition {
//        NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
//    }

////! [0]
//    model: DelegateModel {
////! [0]
//        id: visualModel
//        model: ListModel {
//            id: colorModel
//            ListElement { color: "blue" }
//            ListElement { color: "green" }
//            ListElement { color: "red" }
//            ListElement { color: "yellow" }
//            ListElement { color: "orange" }
//            ListElement { color: "purple" }
//            ListElement { color: "cyan" }
//            ListElement { color: "magenta" }
//            ListElement { color: "chartreuse" }
//            ListElement { color: "aquamarine" }
//            ListElement { color: "indigo" }
//            ListElement { color: "black" }
//            ListElement { color: "lightsteelblue" }
//            ListElement { color: "violet" }
//            ListElement { color: "grey" }
//            ListElement { color: "springgreen" }
//            ListElement { color: "salmon" }
//            ListElement { color: "blanchedalmond" }
//            ListElement { color: "forestgreen" }
//            ListElement { color: "pink" }
//            ListElement { color: "navy" }
//            ListElement { color: "goldenrod" }
//            ListElement { color: "crimson" }
//            ListElement { color: "teal" }
//        }
////! [1]
//        delegate: MouseArea {
//            id: delegateRoot

//            property int visualIndex: DelegateModel.itemsIndex

//            width: 80; height: 80
//            drag.target: icon

//            Rectangle {
//                id: icon
//                width: 72; height: 72
//                anchors {
//                    horizontalCenter: parent.horizontalCenter;
//                    verticalCenter: parent.verticalCenter
//                }
//                color: model.color
//                radius: 3

//                Drag.active: delegateRoot.drag.active
//                Drag.source: delegateRoot
//                Drag.hotSpot.x: 36
//                Drag.hotSpot.y: 36

//                states: [
//                    State {
//                        when: icon.Drag.active
//                        ParentChange {
//                            target: icon
//                            parent: root
//                        }

//                        AnchorChanges {
//                            target: icon;
//                            anchors.horizontalCenter: undefined;
//                            anchors.verticalCenter: undefined
//                        }
//                    }
//                ]
//            }

//            DropArea {
//                anchors { fill: parent; margins: 15 }

//                onEntered: visualModel.items.move(drag.source.visualIndex, delegateRoot.visualIndex)
//            }
//        }
////! [1]
//    }
//}
import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import com.terma.TM 1.0
Rectangle {
    color: "black"
    id: commandSearch
    Image {
        id: background
        width: parent.width
        height: parent.height
        source: "images/search_command_bg.svg"
    }
    TextField {
        id: searchField
        x: 6
        y: 35
        width: 277
        height: 38.048
        font.family: "Avenir"
        font.pixelSize: 16

        style: TextFieldStyle {
            textColor: "white"
            background: Rectangle {
                color: "transparent"
                implicitWidth: 277
                implicitHeight: 35
                border.color: "#3FA9F5"
                border.width: 1
            }
            selectionColor: "white"
            selectedTextColor: "black"
        }

        placeholderText: qsTr("Search...")
        onTextChanged: {commandListModel.nameFilters = [text+"*"+commandListModel.tclFileExtention]}

    }

    ScrollView {
        y: 80
        width: parent.width
        height: 500

        ListView {
            width: parent.width
            height: 500

            model: procs
            Component.onCompleted: {
                console.log(procs.procsCount,procs.runningCount)
            }
            delegate:MouseArea {
                id: delegateRoot
                width: parent.width
                height: 34
                drag.target: icon
                objectName: name
                Component.onCompleted: {
                    console.log(name,procs.procsCount,ProcEntry.name)
                }

                property bool allowInsert: true
                Image {
                    height: 20
                    width: 20
                    sourceSize.width: 50
                    sourceSize.height: 50
                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: 5;
                    }

                    source: "images/arrow_red.svg"
                }
                Rectangle {
                    width: 253
                    height: 30
                    id: icon
                    color: "transparent"
                    border.color: "#3FA9F5"
                    border.width: 1
                    WidgetLabelUI {
                        id: iconText
                        x: 10
                        y: 3
                        text: name
                        color: "#3FA9F5"
                    }
                    anchors {
                        left:parent.left;
                        verticalCenter: parent.verticalCenter;
                        leftMargin: 30;
                    }
                    Drag.active: delegateRoot.drag.active
                    Drag.source: delegateRoot
                    Drag.hotSpot.x: width/2
                    Drag.hotSpot.y: height/2

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: commandSearch.parent
                            }

                            AnchorChanges {
                                target: icon;
                                anchors.left:undefined;
                                anchors.verticalCenter: undefined;
                            }
                        }
                    ]
                }
                onEntered: {
                    icon.color = "#009EDF"
                    iconText.color = "white"
                }
                onReleased: {
                    icon.color = "transparent"
                    iconText.color = "#3FA9F5"
                }

//                DropArea {
//                    z:1
//                    anchors {
//                        fill: parent;
////                        margins: 15
//                    }

//                    onEntered: visualModel.items.move(drag.source.visualIndex, delegateRoot.visualIndex)
//                }
            }
//            delegate: Rectangle {
//                width: parent.width
//                height: 30
//                color: "transparent"
//                Image {
//                    source: "images/WidgetButtonArrow.png"
//                }
//                Rectangle {
//                    x: 25
//                    id: commandTextBorder
//                    WidgetLabelUI {
//                        id: commandText
//                        text: fileBaseName
//                    }
//                }
//                MouseArea {
//                    id: mouseArea
//                    anchors.fill: parent
//                    onDoubleClicked: console.log("DoubleClicked")
//                }


//                DragAndDropTextItem {
//                    x: 20
//                    width: parent.width - 20
//                    height:25
//                    display: fileBaseName
//                }
//            }
        }
    }
}
