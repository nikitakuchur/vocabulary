import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: window
    visible: true
    width: 1080 / 3
    height: 1920 / 3
    title: qsTr("Vocabulary")
    VocabListView {
        id: listView
    }
    VButton {
        text: "+"
        width: 0.1 * Math.max(window.width, window.height)
        height: width
        backgroundRadius: 0.5 * width
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: addItemPopup.open()
    }
    VPopup {
        id: addItemPopup
        width: window.width < window.height ?
                   window.width - 20 : window.width / 2
        contentItem: ColumnLayout {
            spacing: 0.02 * Math.max(window.width, window.height)
            VTextField {
                id: expressionTextField
                placeholderText: qsTr("New expression")
                Layout.fillWidth: true
                Layout.preferredHeight: 0.08 * Math.max(window.width, window.height)
            }
            VTextField {
                id: meaningTextField
                placeholderText: qsTr("New meaning")
                Layout.fillWidth: true
                Layout.preferredHeight: 0.08 * Math.max(window.width, window.height)
            }
            VButton {
                text: qsTr("OK")
                Layout.fillWidth: true
                Layout.preferredHeight: 0.08 * Math.max(window.width, window.height)
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
