import QtQuick 2.12
import "../utils/Database.js" as DB

EditableItemPage {
    visible: false

    onSaveButtonClicked: {
        const id = insert(expressionText, meaningList)
        let meanings = []
        for (let i = 0; i < meaningList.count; i++) {
            meanings.push({ meaning: meaningList.get(i).meaning })
        }
        dictPage.model.append({
            id: id,
            expression: expressionText,
            meanings: meanings,
            level: 0
        });
        stack.pop();
    }

    onVisibleChanged: {
        if (visible) {
            expressionText = "";
            meaningList.clear();
            meaningList.append({ meaning: "" });
        }
    }

    function insert(expression, meanings) {
        let meaningArray = [];
        for (let i = 0; i < meanings.count; i++) {
            meaningArray.push(meanings.get(i).meaning)
        }
        return DB.insert(dictList.get(currentDictIndex).id, expression, meaningArray, 0);
    }
}
