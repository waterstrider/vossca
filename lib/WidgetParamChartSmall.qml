import QtQuick 2.3

Rectangle {
    id: container
    property var model
    property bool replayMode: false
    property var seriesList: []
    property real interval: 500

    color: "transparent"

    Loader {
        id: loader
        asynchronous: true
        sourceComponent: compChart
    }

    WidgetBusyIndicator {
        id: busyIndicator
        running: loader.status == Loader.Loading
        text: "Loading ..."
    }

    Component {
        id: compChart
        WidgetInteractiveChart {
            id: chart
            x: 0
            y: 0
            width: container.width
            height: container.height
            backgroundColor: "#00000000"
            legend.visible: false
            showCursor: replayMode
            zoomEnabled: replayMode
            cursorPosition: replayMode ? model.currentTime : 0

            Component.onCompleted: {
                for (var i = 0; i < seriesList.length; i++) {
                    var sName = seriesList[i]["name"]
                    var sTitle = seriesList[i]["title"]
                    var sBorderColor = seriesList[i]["borderColor"]
                    var sColor = seriesList[i]["color"]
                    chart.addSeries(sName, sTitle, sBorderColor, sColor)

                    if (replayMode) {
                        var hist = model.paramHistory(sName)
                        if (hist != null && hist.length > 0) {
                            var len = hist.length
                            //console.log("History length " + sName + " = " + len);
                            var x, y = 0, yPrev
                            // Add the first point
                            chart.setActiveSeries(sName)
                            chart.addPoint(model.startTime, y)
                            var row
                            //*** DEBUG ***
                            //var sum = 0.0, cnt = 0;
                            //len=Math.min(len,2000);
                            for (var j = 0; j < len; j++) {
                                row = hist[j]
                                if (row["engValidity"] && !isNaN(
                                            row["engValue"])) {
                                    // Add two points for each snapshots
                                    yPrev = y
                                    y = Number(row["engValue"])
                                    if (yPrev != y) {
                                        x = Number(row["receivedTime"])
                                        //var startTime = Date.now();
                                        chart.addPoint(x, yPrev)
                                        chart.addPoint(x, y)
                                        //sum += (Date.now() - startTime);
                                        //cnt++;
                                    }
                                }
                            }
                            //console.log("Total time: " + sum/1000);
                            //console.log("Count: " + cnt);
                            //console.log("Average time: " + sum/(cnt*1000));
                            // Add the last point
                            chart.addPoint(model.endTime, y)
                        }
                    }
                }
            }

            Timer {
                id: timer
                property var prevValue: ({

                                         })
                interval: container.interval
                repeat: true
                running: (!replayMode && model.loaded)
                onTriggered: {
                    if (replayMode)
                        return

                    var t = Date.now()
                    for (var i = 0; i < seriesList.length; i++) {
                        var sName = seriesList[i]["name"]

                        var pValue = model.param(sName).engValue
                        //var pValue = Math.random()*200 - 100;
                        if (!isNaN(pValue)) {
                            if (i in prevValue)
                                chart.addPointToSeries(sName, t, prevValue[i])
                            else
                                chart.addPointToSeries(sName, t, 0)
                            chart.addPointToSeries(sName, t, Number(pValue))
                            prevValue[i] = Number(pValue)
                        }
                    }
                }
            }
        }
    }
}
