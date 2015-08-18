import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: container
    property string url: "http://192.168.142.226/api/get_passes.xml"
    property alias model: listModel
    property int queryLimit: 100
    property int rowCountLimit: 12
    property string querySat: ""
    property string queryStation: ""
    property double queryTime: 0
    property double lastUpdateTime: 0

    XmlListModel {
        id: xmlModel
        source: ""
        query: "/result/pass"

        XmlRole {
            name: "sat"
            query: "sat/string()"
        }
        XmlRole {
            name: "station"
            query: "station/string()"
        }
        XmlRole {
            name: "aos"
            query: "aos/string()"
        }
        XmlRole {
            name: "los"
            query: "los/string()"
        }
        XmlRole {
            name: "duration"
            query: "duration/string()"
        }
    }
    Component.onCompleted: {
        reload()
        update(Date.now())
    }

    ListModel {
        id: listModel
    }

    function reload(time, sat, station) {
        //        var queryString = url + "query.php?limit=" + queryLimit;
        //        queryTime = time;
        //        lastUpdateTime = 0;
        //        queryString += "&time=" + time;

        //        if(sat !== undefined) {
        //            querySat = sat;
        //            queryString += "&sat="+sat;
        //        }

        //        if(station !== undefined) {
        //            queryStation = station;
        //            queryString += "&station="+station;
        //        }

        ////        console.log("Reloading " + queryString);
        //        console.log("Reloading " + url);
        ////        xmlModel.source = queryString;
        xmlModel.source = url
    }

    function update(time) {
        if (xmlModel.status != XmlListModel.Ready)
            return
        time = time / 1000
        //        console.log("Updating " + xmlModel.source,time, xmlModel.xml, xmlModel.count);
        // If  the update time is before the reload time,
        //   reload the model starting from the update time.
        if (time < queryTime) {
            reload(time)
            return
        }


        // Skip update if the elapsed time is less than 900 ms
        //        if(Math.abs(time-lastUpdateTime) < 900) return;

        //        lastUpdateTime = time;
        listModel.clear()

        //        var i;
        //        for(i=0; i < xmlModel.count; i++) {
        //            var item = xmlModel.get(i);
        //            if(item.aos < time)
        //                continue;
        //            else {
        //                var countdownTime = item.aos-time;

        //                // If countdown time is beyond 4 days, do not show and break
        //                if(countdownTime > 4*24*60*60*1000) break;

        //                listModel.append({"sat":item.sat,
        //                                     "station":item.station,
        //                                     "aos":getDayOfWeek(item.aos) + " " + getTime(item.aos),
        //                                     "los":getTime(item.los),
        //                                     "duration":msToDuration(1000*item.duration, "MM:SS"),
        //                                     "count":msToDuration(countdownTime, "HH:MM:SS")});
        //                if(listModel.count >= rowCountLimit) break;
        //            }
        //        }
        var i
        for (i = 0; i < xmlModel.count; i++) {
            var item = xmlModel.get(i)
            if (item.aos < time)
                continue
            else {
                var countdownTime = item.aos - time

                // If countdown time is beyond 4 days, do not show and break
                if (countdownTime > 4 * 24 * 60 * 60)
                    break

                listModel.append({
                                     sat: item.sat,
                                     station: item.station,
                                     aos: getDayOfWeek(
                                              item.aos) + " " + getTime(
                                              item.aos),
                                     los: getTime(item.los),
                                     duration: msToDuration(item.duration,
                                                            "MM:SS"),
                                     count: msToDuration(countdownTime,
                                                         "HH:MM:SS")
                                 })
                if (listModel.count >= rowCountLimit)
                    break
            }
        }
        // If counter reaches the end of the list,
        //   reload the model starting from the update time.
        if (i >= xmlModel.count)
            reload(time, querySat, queryStation)
    }

    function getDayOfWeek(timestamp) {
        var d = new Date(parseInt(timestamp * 1000))
        var weekday = new Array(7)
        weekday[0] = "Sun"
        weekday[1] = "Mon"
        weekday[2] = "Tue"
        weekday[3] = "Wed"
        weekday[4] = "Thu"
        weekday[5] = "Fri"
        weekday[6] = "Sat"
        return weekday[d.getUTCDay()]
    }

    function getTime(timestamp) {
        var d = new Date(parseInt(timestamp * 1000))
        return d.toISOString().substr(11, 8)
    }

    function msToDuration(ms, format) {
        //        var seconds = Math.floor(ms/1000);
        var seconds = Math.floor(ms)
        var hh, mm, ss
        if (format !== undefined && format.toUpperCase() == "MM:SS") {
            // MM:SS
            mm = Math.floor(seconds / 60)
            ss = Math.floor(seconds) % 60
            return padZero(mm, 2) + ':' + padZero(ss, 2)
        } else {
            // HH:MM:SS
            hh = Math.floor(seconds / 3600)
            mm = Math.floor(seconds / 60) % 60
            ss = Math.floor(seconds) % 60
            return padZero(hh, 2) + ':' + padZero(mm, 2) + ':' + padZero(ss, 2)
        }
    }

    function padZero(n, width, z) {
        z = z || '0'
        n = n + ''
        return n.length >= width ? n : new Array(width - n.length + 1).join(
                                       z) + n
    }
}
