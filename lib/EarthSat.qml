import QtQuick 2.0
import Qt3D 2.0
import Qt3D.Shapes 2.0
import "satellite.js" as Satellite

Rectangle {
    id: earth_sat

    property double time: Date.now()
    property bool showSat: (time>0)
    property int count: 0

    width: 500
    height: 500
    color: "transparent"


    Component.onCompleted: {
        pos_list.items = startup(count);
        line_list.items = drawLine(count);
    }
    Component.onDestruction: {
        console.log("EarthSat to be destructed");
        timer1.stop();
        timer2.stop();
    }

    function drawLine(cnt) {
        if(time <= 0) return [];
        var now = new Date(time);

        var tle_line_1 = '1 33396U 08049A   14122.20977318  .00000169  00000-0  10000-3 0   241'
        var tle_line_2 = '2 33396 098.7114 190.7623 0001250 102.0818 349.2161 14.20027033289403'
        var sat = Satellite.satellite;

        var satrec = sat.twoline2satrec (tle_line_1, tle_line_2);

        var position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

        var position_eci = position_and_velocity["position"];

        var gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());

        var satellite_x = position_eci["x"];
        var satellite_y = position_eci["y"];
        var satellite_z = position_eci["z"];

        var position_ecf   = sat.eci_to_ecf (position_eci, gmst);

        var magnitude = Math.sqrt(satellite_x*satellite_x + satellite_y*satellite_y + satellite_z*satellite_z)

        var xx = satellite_x/magnitude
        var yy = satellite_y/magnitude
        var zz = satellite_z/magnitude

        var line_list = []
        var i
        //Future
        for(i = 0; i < 102; i++){
            position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()+cnt+i-50, now.getUTCSeconds());
            position_eci = position_and_velocity["position"];
            gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()+cnt+i-50, now.getUTCSeconds());
            var eci_x = position_eci["x"];
            var eci_y = position_eci["y"];
            var eci_z = position_eci["z"];

            position_ecf   = sat.eci_to_ecf (position_eci, gmst);

            var ecf_x = position_ecf["x"];
            var ecf_y = position_ecf["y"];
            var ecf_z = position_ecf["z"];

            var mag1 = Math.sqrt(eci_x*eci_x + eci_y*eci_y + eci_z*eci_z)
            var mag2 = Math.sqrt(ecf_x*ecf_x + ecf_y*ecf_y + ecf_z*ecf_z)

            xx = ecf_x/mag2
            yy = ecf_y/mag2
            zz = ecf_z/mag2
            var multiply = 0.8
            line_list[3*i] = yy*multiply
            line_list[3*i+1] = zz*multiply
            line_list[3*i+2] = xx*multiply
        }
        return line_list
    }

    function startup(cnt) {
        if(time <= 0) return [0,0,0];
        var now = new Date(time);

        var tle_line_1 = '1 33396U 08049A   14122.20977318  .00000169  00000-0  10000-3 0   241'
        var tle_line_2 = '2 33396 098.7114 190.7623 0001250 102.0818 349.2161 14.20027033289403'
        var sat = Satellite.satellite;
        // Initialize a satellite record
        var satrec = sat.twoline2satrec (tle_line_1, tle_line_2);
        var position_and_velocity = sat.propagate (satrec, now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()+cnt, now.getUTCSeconds());

        var position_eci = position_and_velocity["position"];
        var velocity_eci = position_and_velocity["velocity"];

        var gmst = sat.gstime_from_date (now.getUTCFullYear(), now.getUTCMonth()+1, now.getUTCDate(), now.getUTCHours(), now.getUTCMinutes()+cnt, now.getUTCSeconds());

        var position_gd    = sat.eci_to_geodetic (position_eci, gmst);

        var satellite_x = position_eci["x"];
        var satellite_y = position_eci["y"];
        var satellite_z = position_eci["z"];

        var position_ecf   = sat.eci_to_ecf (position_eci, gmst);

        var magnitude = Math.sqrt(satellite_x*satellite_x + satellite_y*satellite_y + satellite_z*satellite_z)

        var ecf_x = position_ecf["x"];
        var ecf_y = position_ecf["y"];
        var ecf_z = position_ecf["z"];

        var mag2 = Math.sqrt(ecf_x*ecf_x + ecf_y*ecf_y + ecf_z*ecf_z)

        var multiply = 0.8

        var xx = multiply*ecf_x/mag2
        var yy = multiply*ecf_y/mag2
        var zz = multiply*ecf_z/mag2
        return [xx, yy, zz];
    }

    function get_camera_pos(xx, zz){
        var mag = Math.sqrt(xx*xx + 0 + zz*zz)
        var nx = xx/mag
        var ny = 0
        var nz = zz/mag
        var m = 6
        return [nx*m, ny*m, nz*m]
    }
    Item{
        id: camera_list
        property variant items: get_camera_pos(pos_list.posx, pos_list.posy)
        property real posx: camera_list.items[0]
        property real posy: camera_list.items[1]
        property real posz: camera_list.items[2]
    }

    Item{
        id: pos_list
        property variant items: startup(count);
        property real posx: pos_list.items[1];
        property real posy: pos_list.items[2];
        property real posz: pos_list.items[0];
    }
    Item{
        id: line_list
        property variant items: drawLine()
    }

    Timer {
        id: timer1
        interval: 100; running: true; repeat: true
        onTriggered: {
            if(time <= 0) return;
            //count = count + 1
            pos_list.items = startup(count);
            //line_list.items = drawLine(count);
            camera_list.items = get_camera_pos(pos_list.posx, pos_list.posz)
            camera1.eye = Qt.vector3d(camera_list.posx, camera_list.posy, camera_list.posz)
        }
    }

    Timer {
        id: timer2
        interval: 60000; running: true; repeat: true
        onTriggered: {
            if(time <= 0) return;
            //count = count + 1
            line_list.items = drawLine(count)
        }
    }


    Viewport{
        id: base_view
        anchors.fill: parent
        picking: true
        enabled: false
        camera: Camera{
            id: camera1
            eye: Qt.vector3d(6,0,0)
            center: Qt.vector3d(0,0,0)
        }
        light: Light{
            position: camera1.eye
        }

        Line{
            vertices: line_list.items
            effect: Effect{
                color: "yellow"
                useLighting: false
            }
            width: 1.0
        }

        Item3D{
            id: earth
            position: Qt.vector3d(0,0.13,0)
            scale: 3
            mesh: Mesh{
                source: "images/Earth.3ds"
            }
            effect: Effect{
                useLighting: false
                texture: "images/Map2D.png"
            }
        }
        Item3D{
            id: satellite
            property real multiply: 0.8
            property real multiply2: 4
            property real multiply3: 0.5
            enabled: showSat
            position: Qt.vector3d(pos_list.posx, pos_list.posy, pos_list.posz)
            mesh: Mesh{
                source: "images/sat.3ds"
            }
            effect: Effect{
                useLighting: false
                texture: "images/Metal_Co.jpg"
            }
        }
    }
    function check_size(ww, hh){
        var x;
        var y;
        var w; var h;
        if(ww < hh){
            x = 0;
            y = hh/2 - ww/2;
            w = ww;
            h = ww;
        }else if(hh < ww){
            x = ww/2 - hh/2;
            y = 0;
            w = hh;
            h = hh;
        }else{
            x=0;
            y=0;
            w = ww;
            h = hh;
        }
        return [x,y,w,h];
    }
    Item{
        id: size_list
        property variant items: check_size(earth_sat.width, earth_sat.height);
    }


}

