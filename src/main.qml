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
    property int currentDictIndex

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
                        menu.open();
                    }
                }
            }

            Controls.Label {
                id: toolBarLable
                text: dictList.count > 0 ? dictList.get(currentDictIndex).name : ""
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            Controls.ToolButton {
                icon.source: "icons/more.svg"
                Layout.preferredWidth: toolBar.height
                Layout.preferredHeight: toolBar.height
                onClicked: more.open();

                Controls.Menu {
                    id: more
                    Controls.MenuItem {
                        text: qsTr("Rename")
                        onClicked: editеDictPopup.open()
                    }
                    Controls.MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            var oldIndex = currentDictIndex;
                            if (oldIndex > 0) {
                                currentDictIndex--;
                            }
                            DB.deleteDict(dictList.get(oldIndex).id);
                            dictList.remove(oldIndex);
                            if (dictList.count > 0) {
                                DB.readAll(dictList.get(currentDictIndex).id, dictPage.model);
                            } else {
                                dictPage.model.clear();
                            }
                        }
                    }
                }
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

    MainMenu {
        id: menu
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
            currentDictIndex = 0;
        }
    }

    NamePopup {
        id: addDictPopup

        onAddButtonClicked: {
            var id = DB.createDict(text);
            dictList.append({ id: id, name: text });
            addDictPopup.close();
        }

        onVisibleChanged: {
            if (visible) {
                text = "";
            }
        }
    }

    NamePopup {
        id: editеDictPopup

        onAddButtonClicked: {
            var id = DB.renameDict(dictList.get(currentDictIndex).id, text);
            dictList.set(currentDictIndex, { name: text });
            editеDictPopup.close();
        }

        onVisibleChanged: {
            if (visible) {
                text = dictList.get(currentDictIndex).name;
            }
        }
    }
}
