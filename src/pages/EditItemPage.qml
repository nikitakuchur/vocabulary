import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

EditableItemPage {
    expressionText: expression
    visible: false

    RoundButton {
        icon.source: "../icons/clear.svg"
        icon.color: "white"
        defaultColor: Material.color(Material.Pink)

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 10
            bottomMargin: 10
        }

        onClicked: {
            DB.remove(dictList.get(currentDictIndex).id, id);
            dictPage.loadDict();
            stack.pop(dictPage);
        }
    }

    onSaveButtonClicked: {
        expression = expressionText;
        meanings.clear();
        for (let i = 0; i < meaningList.count; i++) {
            meanings.append({ meaning: meaningList.get(i).meaning });
        }
        DB.update(dictList.get(currentDictIndex).id, id, expression, meanings, level);
        stack.pop();
    }

    Component.onCompleted: {
        meaningList.clear();
        for (let i = 0; i < meanings.count; i++) {
            meaningList.append({ meaning: meanings.get(i).meaning });
        }
    }
}
