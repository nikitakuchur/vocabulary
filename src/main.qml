import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "controls"
import "pages"
import "utils/Database.js" as DB

Controls.ApplicationWindow {
    property ListModel dictList: ListModel {}
    property int currentDictId

    id: window
    visible: true
    width: 360
    height: 640
    title: qsTr("Vocabulary")

    header: Controls.ToolBar {
        id: toolBar
        height: Style.toolBar.height

        RowLayout {
            anchors.fill: parent

            Controls.ToolButton {
                icon.source: stack.depth > 1 ? "icons/back.svg" : "icons/menu.svg"
                Layout.preferredWidth: toolBar.height
                Layout.preferredHeight: toolBar.height

                onClicked: {
                    if (stack.depth > 1) {
                        stack.pop();
                    } else {
                        drawer.open();
                    }
                }
            }

            Controls.Label {
                text: "Dictionary"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            Controls.ToolButton {
                icon.source: "icons/more.svg"
                Layout.preferredWidth: toolBar.height
                Layout.preferredHeight: toolBar.height
                //onClicked: menu.open()
            }
        }
    }

    Controls.StackView {
        id: stack
        initialItem: dictPage
        anchors.fill: parent
    }

    DictPage {
        id: dictPage
    }

    Controls.Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        interactive: stack.depth === 1

        background: Rectangle {
            color: "white"
        }

        ListView {
            id: menuListView
            focus: true
            anchors.fill: parent

            header: Column {
                Repeater {
                    property int currentIndex: 0

                    id: repeater
                    model: dictList

                    delegate: Controls.ItemDelegate {
                        width: drawer.width
                        height: Style.listView.itemHeight
                        leftPadding: Units.dp(16)

                        contentItem: Text {
                            color: repeater.currentIndex == index ? "white" : "black"
                            font.pixelSize: Style.font.size
                            text: model.name
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: drawer.verticalCenter
                        }

                        background: Rectangle {
                            color: repeater.currentIndex == index ?
                                       Material.color(Material.Blue) : "white"
                        }

                        onClicked: {
                            repeater.currentIndex = index;
                            currentDictId = dictList.get(index).id;
                            DB.readAll(currentDictId, dictPage.model);
                            drawer.close();
                        }
                    }
                }

                Line { width: drawer.width }

                Controls.ItemDelegate {
                    text: "Add dictionary"
                    font.pixelSize: Style.font.size
                    width: drawer.width
                    height: Style.listView.itemHeight
                    leftPadding: Units.dp(16)
                    onClicked: {
                        addDictPopup.open();
                    }
                }
            }

            delegate: Controls.ItemDelegate {
                width: parent.width
                text: model.title
                font.pixelSize: Style.font.size
                height: Style.listView.itemHeight
                leftPadding: Units.dp(16)
                onClicked: {
                    stack.push(model.source);
                    drawer.close();
                }
            }

            model: ListModel {
                ListElement { title: "Quizzes"; source: "qrc:/pages/QuizPage.qml" }
                ListElement { title: "About"; source: "qrc:/pages/AboutPage.qml" }
            }
        }
    }

    onClosing: {
        if (stack.depth > 1) {
            close.accepted = false;
            stack.pop();
        }
    }

    Component.onCompleted: {
        DB.init();
        DB.getDicts(dictList);
        if (dictList.count > 0) {
            currentDictId = dictList.get(0).id;
        }
    }
    Popup {
        id: addDictPopup
        width: window.width * 0.8
        anchors.centerIn: parent

        contentItem: ColumnLayout {
            spacing: Units.dp(16)

            TextField {
                id: nameTextField
                placeholderText: "Name"
                Layout.fillWidth: true
            }

            Button {
                text: "Add"
                Layout.fillWidth: true
                onClicked: {
                    var id = DB.createDict(nameTextField.text);
                    dictList.append({ id: id, name: nameTextField.text });
                    addDictPopup.close();
                }
            }
        }

        onVisibleChanged: {
            if (visible) {
                nameTextField.text = "";
            }
        }
    }
}
