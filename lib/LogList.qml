import QtQuick 2.0
import QLogWatcher 1.0

LogWatcher {
    id: logList
    property alias logModel: listModel
    ListModel {
        id: listModel
    }
    onLogged: {
        listModel.append({
                             sv: sv,
                             source: source,
                             logTime: logTime,
                             message: message
                         })
    }
}
