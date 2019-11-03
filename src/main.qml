import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "controls"
import "pages"
import "utils/Database.js" as DB

Controls.ApplicationWindow {
    property ListModel dictList: ListModel {}
    property string currentDict

    id: window
    visible: true
    width: 360
    height: 640
    title: qsTr("Vocabulary")

    header: Controls.ToolBar {
        id: toolBar
        height: Style.toolBar.height

        Row {
            anchors.fill: parent

            Controls.ToolButton {
                text: stack.depth > 1 ? "‹" : "⋮"
                font.pixelSize: Units.dp(32)
                height: toolBar.height
                width: height

                onClicked: {
                    if (stack.depth > 1) {
                        stack.pop();
                    } else {
                        drawer.open();
                    }
                }
            }
        }
    }

    Controls.StackView {
        id: stack
        initialItem: mainPage
        anchors.fill: parent
    }

    MainPage {
        id: mainPage
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
                    id: repeater
                    model: dictList

                    delegate: Controls.ItemDelegate {
                        text: model.name
                        font.pixelSize: Style.font.size
                        width: drawer.width
                        height: Style.listView.itemHeight
                        leftPadding: Units.dp(16)
                        onClicked: {
                            currentDict = dictList.get(index).name;
                            DB.readAll(currentDict, mainPage.model);
                            drawer.close();
                        }
                    }
                }

                Controls.MenuItem {
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

    Popup {
        id: addDictPopup
        width: window.width * 0.5

        Column {
            anchors.fill: parent
            spacing: Units.dp(16)

            TextField {
                id: nameTextField
                placeholderText: "Name"
                width: parent.width
            }

            Button {
                text: "Add"
                width: parent.width
                onClicked: {
                    dictList.append({ name: nameTextField.text });
                    DB.createDict(nameTextField.text);
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

    onClosing: {
        if (stack.depth > 1) {
            close.accepted = false;
            stack.pop();
        }
    }

    Component.onCompleted: {
        var tables = DB.getDicts();
        for (var table of tables) {
            dictList.append({ name: table });
        }
        if (dictList.count > 0) {
            currentDict = dictList.get(0).name;
        }
    }
}
