import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Controls.Page {
    property alias model: listModel

    ListModel {
        id: listModel
        Component.onCompleted: {
            if (dictList.count > 0) {
                DB.readAll(dictList.get(currentDictIndex).id, listModel);
            }
        }
    }

    DictListView {
        id: listView
        model: listModel
    }

    RoundButton {
        icon.source: "../icons/add.svg"
        icon.color: "white"
        visible: dictList.count > 0
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            stack.push(addItemPage);
        }
    }

    AddItemPage {
        id: addItemPage
        visible: false
    }
}
