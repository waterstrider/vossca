import QtQuick 2.0
import QtCommercial.Chart 1.3

Rectangle {
    Repeater {
        model: [{"time":0, "engValue":10},
            {"time":0.1, "engValue":20},
            {"time":0.2, "engValue":30},
            {"time":0.3, "engValue":40},
            {"time":0.4, "engValue":50}]
        Text {
            text: "("+ modelData.time +"," + modelData.engValue +")"
            y: modelData.time * 100.0
        }
    }
    ChartView {
        title: "Power"
        y:100
        width: 397; height: 255
        theme: ChartView.ChartThemeBlueCerulean
        //backgroundColor: "transparent"
        legend.visible: false

        ValueAxis {
            id: xAxis1
            min: 0
            max: 10
            labelFormat: "%d"
        }

        ValueAxis {
            id: yAxis1
            min: -100
            max: 100
        }

        AreaSeries {
            id: areaSeries1
            name: "Power"
            color: "#88D52B1E"
            borderColor: "#FFD52B1E"
            borderWidth: 1
            axisX: xAxis1
            axisY: yAxis1
            lowerSeries: LineSeries {
                id: lowerSeries1
                //XYPoint { x:0; y:50 }
                XYPoint { x:1; y:40 }
                Repeater {
                    model: [2,3,4,5,6]
                    XYPoint { x:2; y:0 }
                }
                //XYPoint { x:7; y:30 }
                //XYPoint { x:8; y:20 }
                //XYPoint { x:9; y:10 }
            }
            upperSeries: LineSeries {
                id: upperSeries1
                //XYPoint { x:0; y:10 }
                //XYPoint { x:1; y:20 }
                Repeater {
//                    model: [{"time":0, "engValue":10},
//                        {"time":0.1, "engValue":20},
//                        {"time":0.2, "engValue":30},
//                        {"time":0.3, "engValue":40},
//                        {"time":0.4, "engValue":50}]
                    model: [2,3,4,5,6]
                    XYPoint { x:2; y:100 }
                }

                //XYPoint { x:7; y:30 }
                //XYPoint { x:8; y:40 }
                //XYPoint { x:9; y:50 }
            }
        }
    }

}
