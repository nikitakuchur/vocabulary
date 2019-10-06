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
        width: 50
        height: 50
        backgroundRadius: 25
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
        contentItem: ColumnLayout {
            spacing: 8
            Text {
                font.pointSize: 10
                color: "#aaa9a5"
                text: "Expression:"
            }
            VTextField {
                id: expressionTextField
                Layout.fillWidth: true
            }
            Text {
                font.pointSize: 10
                color: "#aaa9a5"
                text: "Meaning:"
            }
            VTextField {
                id: meaningTextField
                Layout.fillWidth: true
            }
            VButton {
                text: "OK"
                Layout.minimumHeight: 40
                Layout.topMargin: 20
                Layout.fillWidth: true
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
