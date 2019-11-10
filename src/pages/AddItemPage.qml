import QtQuick 2.12
import "../utils/Database.js" as DB

EditableItemPage {
    visible: false

    onSaveButtonClicked: {
        const id = DB.insert(dictList.get(currentDictIndex).id, expressionText, meaningList, 0);
        let meanings = []
        for (let i = 0; i < meaningList.count; i++) {
            meanings.push({ meaning: meaningList.get(i).meaning })
        }
        dictPage.model.append({
            id: id,
            expression: expressionText,
            meanings: meanings
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
}
