import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Item {
    MainListView {
        id: listView
    }
    RoundButton {
        text: qsTr("New")
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            addItemPopup.open()
        }
    }
    Popup {
        id: addItemPopup
        width: window.width < window.height ?
                   window.width - 20 : window.width / 2
        contentItem: ColumnLayout {
            spacing: Units.dp(10)
            TextField {
                id: expressionTextField
                placeholderText: qsTr("New expression")
                Layout.fillWidth: true
                Layout.preferredHeight: Style.textField.height
            }
            TextField {
                id: meaningTextField
                placeholderText: qsTr("New meaning")
                Layout.fillWidth: true
                Layout.preferredHeight: Style.textField.height
            }
            Button {
                text: qsTr("OK")
                Layout.fillWidth: true
                Layout.preferredHeight: Style.button.height
                onClicked: {
                    var rowid = parseInt(DB.insert(expressionTextField.text, [meaningTextField.text]))
                    listView.model.append({
                        id: rowid,
                        expression: expressionTextField.text,
                        meanings: [{ meaning: meaningTextField.text }]
                    })
                    addItemPopup.close()
                }
            }
        }
        onClosed: {
            expressionTextField.text = ""
            meaningTextField.text = ""
        }
    }
}
