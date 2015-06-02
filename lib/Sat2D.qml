import QtQuick 2.0
import "satellite.js" as Satellite

Rectangle {
    property double time: Date.now()
    property bool showSat: (time>0)

    width: 800
    height: 400
    color: "transparent"

    Component.onDestruction: {
        console.log("Sat2D to be destructed");
        timer1.stop();
    }

    function startup() {
        if(time <= 0) return [0, 0];
        var now = new Date(time);

        var tle_line_1 = '1 33396U 08049A   14122.20977318  .00000169  00000-0  10000-3 0   241'
        var tle_line_2 = '2 33396 098.7114 190.7623 0001250 102.0818 349.2161 14.20027033289403'
        var sat = Satellite.satellite;

        var satrec = sat.twoline2satrec (tle_line_1, tle_line_2);

        var position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

        var position_eci = position_and_velocity["position"];
        var velocity_eci = position_and_velocity["velocity"];

        var gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

        var position_gd    = sat.eci_to_geodetic (position_eci, gmst);

        var longitude = position_gd["longitude"];
        var latitude  = position_gd["latitude"];
        var height    = position_gd["height"];

        var longitude_str = sat.degrees_long (longitude);
        var latitude_str  = sat.degrees_lat  (latitude);

        return [longitude_str, latitude_str];
    }

    function drawLine(ctx, ww, hh, xx, yy) {
        if(time <= 0) return;
        var now = new Date(time);

        var tle_line_1 = '1 33396U 08049A   14122.20977318  .00000169  00000-0  10000-3 0   241'
        var tle_line_2 = '2 33396 098.7114 190.7623 0001250 102.0818 349.2161 14.20027033289403'
        var sat = Satellite.satellite;

        var satrec = sat.twoline2satrec (tle_line_1, tle_line_2);

        var position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

        var position_eci = position_and_velocity["position"];
        var velocity_eci = position_and_velocity["velocity"];

        var gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

        var position_gd    = sat.eci_to_geodetic (position_eci, gmst);

        var longitude = position_gd["longitude"];
        var latitude  = position_gd["latitude"];
        var height    = position_gd["height"];

        var longitude_str = sat.degrees_long (longitude);
        var latitude_str  = sat.degrees_lat  (latitude);

        var x = ww * ( 0.5 + ( longitude_str / 360 ) );
        var y = hh * ( 0.5 - ( latitude_str / 180 ) );

        var begin_x = x;
        var begin_y = y;

        var previous_x;
        var previous_y;

        var next_y;

        ctx.lineWidth = 1;
        ctx.strokeStyle = "grey";
        ctx.beginPath();
        ctx.moveTo(begin_x, begin_y);
        var i
        //Future
        for(i = 1; i < 156; i++){
            position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()+i, now.getUTCSeconds());
            position_eci = position_and_velocity["position"];
            gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()+i, now.getUTCSeconds());
            position_gd    = sat.eci_to_geodetic (position_eci, gmst);
            longitude = position_gd["longitude"];
            latitude  = position_gd["latitude"];
            longitude_str = sat.degrees_long (longitude);
            latitude_str  = sat.degrees_lat  (latitude);
            previous_x = x
            previous_y = y
            x = ww * ( 0.5 + ( longitude_str / 360 ) );
            y = hh * ( 0.5 - ( latitude_str / 180 ) );
            if(x - previous_x > 100){
                next_y = previous_y + ((y-previous_y)*(previous_x/(ww-x+previous_x)))
                ctx.lineTo(xx, next_y);
                ctx.moveTo(ww, next_y);
            }
            ctx.lineTo(x,y);
        }
        ctx.moveTo(begin_x, begin_y);
        previous_x = begin_x
        previous_y = begin_y
        //Past
        for(i = 1; i < 156; i++){
            position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()-i, now.getUTCSeconds());
            position_eci = position_and_velocity["position"];
            gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()-i, now.getUTCSeconds());
            position_gd    = sat.eci_to_geodetic (position_eci, gmst);
            longitude = position_gd["longitude"];
            latitude  = position_gd["latitude"];
            longitude_str = sat.degrees_long (longitude);
            latitude_str  = sat.degrees_lat  (latitude);
            if(i===1){
                previous_x = begin_x;
                previous_y = begin_y;
            }else{
                previous_x = x;
                previous_y = y;
            }
            x = ww * ( 0.5 + ( longitude_str / 360 ) );
            y = hh * ( 0.5 - ( latitude_str / 180 ) );
            if(x - previous_x < -100){
                next_y = previous_y + ((y-previous_y)*(previous_x/(ww-x+previous_x)))
                ctx.lineTo(ww ,next_y);
                ctx.moveTo(0 , next_y);
            }
            ctx.lineTo(x,y);
        }
        ctx.stroke()
    }

    Item{
        id: pos_list
        property variant items: startup()
    }


    Timer {
        id: timer1
        interval: 500; running: true; repeat: true
        onTriggered: {
            if(time <= 0) return;
            pos_list.items = startup()
        }
    }


    Image {
        y: 20
        anchors.fill: parent
        source: "images/Map2D_transparent.png"
        asynchronous: true

        Canvas {
            id: sat_line
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                drawLine(ctx, parent.width, parent.height, parent.x, parent.y);
            }
            Timer {
                interval: 6060000; running: true; repeat: true; onTriggered: sat_line.requestPaint();
            }
        }
        Image {
            id: station
            source: "images/sat_dish.png"
            width: 10
            height: 10
            x: parent.width * ( 0.5 + ( 100.925177 / 360 ) ) - 5 ;
            y: parent.height * ( 0.5 - ( 13.105726 / 180 ) ) - 5 ;
        }

        Image {
            id: satellite
            source: "images/THEOS.png"
            width: 20
            height: 17
            visible: showSat
            x: parent.width * ( 0.5 + ( pos_list.items[0] / 360 ) ) - 10;
            y: parent.height * ( 0.5 - ( pos_list.items[1] / 180 ) ) - 8;
        }
    }
}
