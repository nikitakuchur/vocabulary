import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import Units 1.0
import Style 1.0
import "../controls"

Item {
    id: mainView
    MainListView {
        id: listView
    }
    RoundButton {
        text: "+"
        fontSize: Units.dp(40)
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
                    listView.model.append({
                        expression: expressionTextField.text,
                        meaning: meaningTextField.text
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
