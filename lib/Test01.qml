import QtQuick 2.0
import com.terma.TM 1.0

Rectangle {
    id: vosscaModel
    width: 100
    height: 62
    property var param : {"a":""}
    Component.onCompleted: {
        console.log("Creating");
        param['a'] = paramComp.createObject(vosscaModel,{"name":"SBCR_VPM_IDENTIFIER"});
        console.log("Object" + param['a']);
        console.log("Object" + param['a'].name);
        console.log("Object" + param['a'].rawValue);
        test03.param = param['a'];
    }

    Component.onDestruction: {

    }

    Component {
        id: paramComp
        Item {
            property alias name: par.name
            property alias rawValue: par.rawValue
            TmParam {
                id: par
            }
        }
    }

    Test03 {
       id: test03
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            param['a'].name = "GAUCON";
            console.log("Name: " + param['a'].rawValue);
        }
    }

}
