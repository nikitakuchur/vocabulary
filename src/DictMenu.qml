import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import "utils/Database.js" as DB
import "controls"

Controls.Menu {
    id: more
    modal: true
    DictMenuItem {
        text: qsTr("Rename")
        onClicked: editеDictPopup.open()
    }

    Line {
        width: parent.width
    }

    DictMenuItem {
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
