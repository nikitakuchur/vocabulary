import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import Units 1.0
import Style 1.0
import "../controls"

Controls.Page {
    property alias expressionText: expressionTextField.text
    property var meaningList: ListModel { ListElement { meaning: "" }}
    signal saveButtonClicked()

    id: root

    Flickable {
        anchors.fill: parent
        contentHeight: column.height + parent.height * 0.2
        Controls.ScrollBar.vertical: Controls.ScrollBar {}

        Column {
            id: column
            spacing: Units.dp(16)

            Text {
                text: qsTr("Expression")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                topPadding: Units.dp(16)
                leftPadding: Units.dp(16)
            }

            TextField {
                id: expressionTextField
                text: ""
                wrapMode: TextField.Wrap
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Units.dp(16)
            }

            Line { width: root.width }

            Text {
                text: qsTr("Meaning")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                leftPadding: Units.dp(16)
            }

            Repeater {
                id: repeater
                model: meaningList

                RowLayout {
                    width: root.width
                    height: meaningTextField.height

                    TextField {
                        id: meaningTextField
                        text: modelData
                        wrapMode: TextField.Wrap

                        Layout.fillWidth: true
                        Layout.leftMargin: Units.dp(16)
                        Layout.rightMargin: repeater.count > 1 ? 0 : Units.dp(16)

                        onTextChanged: {
                            text = text.replace("_", " ");
                            meaningList.get(index).meaning = text;
                        }
                    }

                    Button {
                        visible: repeater.count > 1
                        text: "–"

                        Layout.alignment: Qt.AlignTop
                        Layout.preferredWidth: implicitHeight
                        Layout.rightMargin: Units.dp(16)
                        defaultColor: Material.color(Material.Pink)

                        onClicked: {
                            repeater.model.remove(index);
                        }
                    }
                }
            }

            Button {
                text: qsTr("Add meaning")
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
        icon.source: "../icons/done.svg"
        icon.color: "white"

        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }

        onClicked: saveButtonClicked()
    }
}
