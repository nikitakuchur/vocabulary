import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Controls.Page {
    property alias model: listView.model

    visible: false

    DictListView {
        id: listView
        model: ListModel {}
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
    }

    Component.onCompleted: {
        loadDict();
    }

    function loadDict() {
        if (dictList.count > 0) {
            model.clear();
            let array = DB.readAll(dictList.get(currentDictIndex).id);
            for (let val of array) {
                model.append(val);
            }
        }
    }
}
