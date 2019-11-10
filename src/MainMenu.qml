import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Layouts 1.12
import Units 1.0
import Style 1.0
import "controls"
import "utils/Database.js" as DB

Controls.Drawer {
    id: drawer
    width: Math.min(parent.width, parent.height) / 3 * 2
    height: parent.height
    interactive: stack.depth === 1

    background: Rectangle {
        color: "white"
    }

    Column {
        Repeater {
            id: repeater
            model: dictList

            delegate: Controls.ItemDelegate {
                id: item
                width: drawer.width
                height: Style.listView.itemHeight
                leftPadding: Units.dp(16)

                contentItem: Text {
                    color: currentDictIndex == index ? "white" : "black"
                    font.pixelSize: Style.font.size
                    text: model.name
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenter: drawer.verticalCenter
                    Layout.fillWidth: true
                }

                background: Rectangle {
                    property color defaultColor: currentDictIndex == index ?
                                                     Material.color(Material.Blue) : "white"
                    color: item.pressed ?
                               Qt.rgba(defaultColor.r - 0.1, defaultColor.g - 0.1, defaultColor.b - 0.1, 1) :
                               defaultColor
                }

                onClicked: {
                    currentDictIndex = index;
                    DB.readAll(dictList.get(index).id, dictPage.model);
                    drawer.close();
                }
            }
        }

        Line { width: drawer.width }

        Controls.ItemDelegate {
            text: qsTr("Add dictionary")
            font.pixelSize: Style.font.size
            width: drawer.width
            height: Style.listView.itemHeight
            leftPadding: Units.dp(16)
            onClicked: {
                addDictPopup.open();
            }
        }

        Controls.ItemDelegate {
            id: quizzesItem
            width: parent.width
            text: "Quizzes"
            font.pixelSize: Style.font.size
            enabled: dictPage.model.count > 4
            height: Style.listView.itemHeight
            leftPadding: Units.dp(16)
            onClicked: {
                stack.push("qrc:/pages/QuizzesPage.qml");
                drawer.close();
            }
        }

        Controls.ItemDelegate {
            width: parent.width
            text: "About"
            font.pixelSize: Style.font.size
            height: Style.listView.itemHeight
            leftPadding: Units.dp(16)
            onClicked: {
                stack.push("qrc:/pages/AboutPage.qml");
                drawer.close();
            }
        }
    }
}
