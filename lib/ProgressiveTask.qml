import QtQuick 2.3
import QtQuick.Controls 1.2

Item {
    id: container
    signal execute

    property double progress: 0
    property bool running: false

    Timer {
        id: timer
        running: container.running
        interval: 1
        repeat: true
        onTriggered: container.execute()
    }
}
//    QtObject {
//        id: task
//        signal trigger
//        signal execute
//        property bool running: false
//        property var state: {"x": 0, "y":0}
//        property string text

//        onExecute: {
//            console.log("Execute " + state.y);
//            for(var i = 0; i< 100; i++) {
//                state.x = state.x + 1;
//                if(state.x > 10000) {
//                    state.x = 0;
//                    state.y = state.y + 1;
//                    task.text = "Y = " + state.y;
//                }
//            }
//            task.trigger();
//        }

//        onTrigger: {
//            console.log("Trigger " + state.y);
//            if(running) {
//                task.execute();
//                //task.trigger();
//            }
//        }

//        onRunningChanged: {
//            console.log("Running changed " + state.y);
//            if(running)
//                task.trigger();
//        }
//    }

