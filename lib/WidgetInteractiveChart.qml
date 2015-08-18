import QtQuick 2.3
//import QtCommercial.Chart 1.4
import QtCharts 2.0

ChartView {
    id: chartView

    property real cursorPosition: 0
    property alias cursorColor: cursorLine.color
    property alias showCursor: cursorLine.visible
    property alias tickCount: _xAxis.tickCount
    property color labelColor: "#AAAAAA"
    property color axisColor: "#AAAAAA"
    property bool zoomEnabled: false
    property bool zooming: false
    property bool useDateTime: true

    property var _activeSeries
    property var _seriesList: ({

                               })
    property int _seriesCount: 0
    property real _xMin: Number.POSITIVE_INFINITY
    property real _xMax: Number.NEGATIVE_INFINITY
    property real _yMin: Number.POSITIVE_INFINITY
    property real _yMax: Number.NEGATIVE_INFINITY

    width: 397
    height: 255
    backgroundColor: "#00000000"
    legend.visible: false
    animationOptions: ChartView.NoAnimation

    onCursorPositionChanged: {
        if (cursorLine.count >= 2) {
            var point0 = cursorLine.at(0)
            var point1 = cursorLine.at(1)
            cursorLine.replace(point0.x, point0.y, cursorPosition, _yAxis.min)
            cursorLine.replace(point1.x, point1.y, cursorPosition, _yAxis.max)
        }
    }

    DateTimeAxis {
        id: _xAxis
        color: axisColor
        labelsColor: labelColor
        labelsVisible: false
        min: new Date(_xMin)
        max: new Date(zooming ? cursorPosition : _xMax)
        //format: "hh:mm:ss"
        format: ""
        tickCount: 2
    }
    //    ValueAxis {
    //        id: _xAxis
    //        color: axisColor; labelsColor: labelColor
    ////        min: _xMin
    ////        max: zooming?cursorPosition:_xMax
    //        min: 0
    //        max: zooming?cursorPosition:_xMax
    //        labelFormat: "%d"
    //    }
    ValueAxis {
        id: _yAxis
        color: axisColor
        labelsColor: labelColor
        min: 1.1 * Math.min(0, _yMin)
        max: 1.1 * Math.max(0, _yMax)
    }

    AreaSeries {
        color: "#44D3AB21"
        borderColor: "#FFD3AB21"
        borderWidth: 1
        axisX: _xAxis
        axisY: _yAxis
        visible: false
        //        lowerSeries: LineSeries {
        //            XYPoint { x: 0; y: 0}
        //            XYPoint { x: 200000000000; y: 0}
        //        }
        lowerSeries: LineSeries {
        }
        upperSeries: LineSeries {
        }
    }
    AreaSeries {
        color: "#8821D3AB"
        borderColor: "#FF21D3AB"
        borderWidth: 1
        axisX: _xAxis
        axisY: _yAxis
        visible: false
        //        lowerSeries: LineSeries {
        //            XYPoint { x: 0; y: 0}
        //            XYPoint { x: 200000000000; y: 0}
        //        }
        lowerSeries: LineSeries {
        }
        upperSeries: LineSeries {
        }
    }
    AreaSeries {
        color: "#CCAB21D3"
        borderColor: "#FFAB21D3"
        borderWidth: 1
        axisX: _xAxis
        axisY: _yAxis
        visible: false
        //        lowerSeries: LineSeries {
        //            XYPoint { x: 0; y: 0}
        //            XYPoint { x: 200000000000; y: 0}
        //        }
        lowerSeries: LineSeries {
        }
        upperSeries: LineSeries {
        }
    }

    LineSeries {
        id: cursorLine
        color: "red"
        visible: false
        axisX: _xAxis
        axisY: _yAxis
        width: 2
        XYPoint {
            x: cursorPosition
            y: _yAxis.min
        }
        XYPoint {
            x: cursorPosition
            y: _yAxis.max
        }
    }

    MouseArea {
        anchors.fill: parent
        onDoubleClicked: {
            zooming = zoomEnabled && !zooming
        }
    }

    function addSeries(name, title, borderColor, color) {
        if (_seriesCount >= chartView.count - 1)
            return false

        var newSeries = chartView.series(_seriesCount)
        _seriesCount++
        newSeries.name = title
        if (typeof color !== 'undefined')
            newSeries.color = color
        if (typeof borderColor !== 'undefined')
            newSeries.borderColor = borderColor
        newSeries.visible = true
        _seriesList[name] = newSeries
        return true
    }

    function showSeries(name) {
        if (name in _seriesList) {
            _seriesList[name].visible = true
        }
    }
    function hideSeries(name) {
        if (name in _seriesList) {
            _seriesList[name].visible = false
        }
    }

    function setActiveSeries(seriesName) {
        if (seriesName in _seriesList) {
            _activeSeries = _seriesList[seriesName]
        }
    }

    function addPoint(x, y) {
        _activeSeries.upperSeries.append(x, y)
        _activeSeries.lowerSeries.append(x, 0)
        if (x < _xMin)
            _xMin = x
        if (x > _xMax)
            _xMax = x
        if (y < _yMin)
            _yMin = y
        if (y > _yMax)
            _yMax = y
    }

    function addPointToSeries(seriesName, x, y) {
        if (seriesName in _seriesList) {
            var s = _seriesList[seriesName]

            s.upperSeries.append(x, y)
            s.lowerSeries.append(x, 0)

            if (x < _xMin)
                _xMin = x
            if (x > _xMax)
                _xMax = x
            if (y < _yMin)
                _yMin = y
            if (y > _yMax)
                _yMax = y
        }
    }
}
