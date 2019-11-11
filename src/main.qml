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

            Text {
                id: toolBarLable
                text: dictList.count > 0 ? dictList.get(currentDictIndex).name : ""
                visible: stack.depth == 1
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Controls.ToolButton {
                icon.source: "icons/more.svg"
                visible: stack.depth == 1
                Layout.preferredWidth: toolBar.height
                Layout.preferredHeight: toolBar.height
                onClicked: dictMenu.open();

                DictMenu {
                    id: dictMenu
                }
            }
        }
    }

    Controls.StackView {
        id: stack
        initialItem: dictPage
        anchors.fill: parent

        onCurrentItemChanged: {
            if (currentItem == dictPage) {
                dictPage.loadDict();
            }
        }
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
        let dicts = DB.getDicts();
        for (let dict of dicts) {
            dictList.append(dict);
        }
        if (dictList.count > 0) {
            currentDictIndex = 0;
        }
    }

    NamePopup {
        id: addDictPopup

        onOkButtonClicked: {
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
        id: editDictPopup

        onOkButtonClicked: {
            var id = DB.renameDict(dictList.get(currentDictIndex).id, text);
            dictList.set(currentDictIndex, { name: text });
            editDictPopup.close();
        }

        onVisibleChanged: {
            if (visible) {
                text = dictList.get(currentDictIndex).name;
            }
        }
    }

    Popup {
        id: deleteDictPopup
        width: window.width * 0.8

        contentItem: ColumnLayout {
            spacing: Units.dp(16)

            Text {
                id: textField
                text: qsTr("Are you sure?")
                font.pixelSize: Style.font.size
                Layout.fillWidth: true
            }

            RowLayout {
                Button {
                    text: qsTr("No")
                    Layout.fillWidth: true
                    onClicked: deleteDictPopup.close()
                }

                Button {
                    text: qsTr("Yes")
                    Layout.fillWidth: true
                    onClicked: {
                        var oldIndex = currentDictIndex;
                        if (oldIndex > 0) {
                            currentDictIndex--;
                        }
                        DB.deleteDict(dictList.get(oldIndex).id);
                        dictList.remove(oldIndex);
                        if (dictList.count > 0) {
                            dictPage.loadDict();
                        } else {
                            dictPage.model.clear();
                        }
                        deleteDictPopup.close();
                    }
                }
            }
        }
    }
}
