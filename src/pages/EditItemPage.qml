import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Item {
    id: root
    Flickable {
        anchors.fill: parent
        contentHeight: column.height + parent.height / 2
        Controls.ScrollBar.vertical: Controls.ScrollBar { }
        Column {
            id: column
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
                model: ListModel { id:m }
                TextField {
                    text: modelData
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Units.dp(16)
                }
                Component.onCompleted: {
                    for (var i = 0; i < meanings.count; i++) {
                        model.append({ meaning: meanings.get(i).meaning })
                    }
                }
            }
            Button {
                text: "Add meaning"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Units.dp(16)
                onClicked: {
                    repeater.model.append({ meaning: "" });
                }
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
            expression = expressionTextField.text;
            meanings.clear();
            for (var i = 0; i < repeater.count; i++) {
                meanings.append({ meaning: repeater.itemAt(i).text });
            }
            DB.update(id, expression, meanings);
            stack.pop();
        }
    }
}
