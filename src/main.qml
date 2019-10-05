import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: window
    visible: true
    width: 1080 / 3
    height: 1920 / 3
    title: qsTr("Vocabulary")
    VocabListView {}
    Button {
        id: button
        width: 68
        height: 68
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        contentItem: Text {
            text: "+"
            font.pointSize: 32
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 100
            color: button.pressed ?  "#008dbe" : "#2eaadc"
            radius: 50
        }

        onClicked: {
            console.log("!!!")
        }
    }
}
