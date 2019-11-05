import QtQuick 2.12
import QtQuick.Layouts 1.12
import Units 1.0
import "controls"

Popup {
    property alias text: textField.text
    signal addButtonClicked()
    id: popup
    width: window.width * 0.8

    contentItem: ColumnLayout {
        spacing: Units.dp(16)

        TextField {
            id: textField
            placeholderText: qsTr("Name")
            Layout.fillWidth: true
        }

        Button {
            text: qsTr("OK")
            Layout.fillWidth: true
            onClicked: popup.addButtonClicked()
        }
    }
}
