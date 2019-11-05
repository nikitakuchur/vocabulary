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

    ListView {
        id: menuListView
        focus: true
        anchors.fill: parent

        header: Column {
            Repeater {
                //property int currentIndex: 0

                id: repeater
                model: dictList

                delegate: Controls.ItemDelegate {
                    id: item
                    width: drawer.width
                    height: Style.listView.itemHeight
                    leftPadding: Units.dp(16)

                    contentItem: RowLayout {
                        Controls.Label {
                            color: currentDictIndex == index ? "white" : "black"
                            font.pixelSize: Style.font.size
                            text: model.name
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: drawer.verticalCenter
                            Layout.fillWidth: true
                        }
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
