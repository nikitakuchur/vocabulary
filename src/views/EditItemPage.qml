import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Item {
    property int index
    property string id
    property string expression: ""
    property variant meanings: [""]

    id: root
    visible: true
    Column {
        spacing: Units.dp(16)
        Controls.Label {
            text: "Expression"
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            padding: Units.dp(16)
            bottomPadding: 0
        }
        TextField {
            text: expression
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Units.dp(16)
        }
        Line { width: root.width }
        Controls.Label {
            text: "Meaning"
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            leftPadding: Units.dp(16)
        }
        Repeater {
            model: meanings
            TextField {
                text: modelData
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Units.dp(16)
            }
        }
    }
    RoundButton {
        text: qsTr("Delete")
        defaultColor: Style.button.redColor
        anchors {
            left: parent.left
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            DB.deleteRow(id)
            mainView.model.remove(index)
            stack.pop()
            stack.pop()
        }
    }
    RoundButton {
        text: qsTr("Save")
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            console.log("save")
        }
    }
}
