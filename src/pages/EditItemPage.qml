import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Item {
    id: root
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
            id: expressionTextField
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
            id: repeater
            model: meanings
            TextField {
                text: meanings.get(index).meaning
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Units.dp(16)
            }
        }
        Button {
            text: "Add meaning"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Units.dp(16)
            onClicked: {
                meanings.append({ meaning: "" });
            }
        }
    }
    RoundButton {
        text: qsTr("Delete")
        defaultColor: Style.button.redColor
        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            DB.deleteRow(id);
            listModel.clear();
            DB.readAll(listModel);
            stack.pop(mainPage);
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
            DB.update(id, expressionTextField.text, meanings);
            expression = expressionTextField.text;
            meanings = [{ meaning: "hello" }];
            stack.pop();
        }
    }
}
