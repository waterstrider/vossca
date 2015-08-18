import QtQuick 2.0
import QtQuick.Controls 1.0
import QtWebKit 3.0
import QtWebKit.experimental 1.0

ScrollView {
    width: 1920
    height: 1080
    WebView {
        id: webview
        url: "https://192.168.142.226/countdown#/index"
        anchors.fill: parent
        experimental.certificateVerificationDialog: Item {
            Component.onCompleted: {
                model.accept()
            }
        }
        onNavigationRequested: {
            // detect URL scheme prefix, most likely an external link
            var schemaRE = /^\w+:/
            if (schemaRE.test(request.url)) {
                request.action = WebView.AcceptRequest
                console.log("accept")
            } else {
                request.action = WebView.IgnoreRequest
                console.log("ignore")
                // delegate request.url here
            }
        }
    }
}
