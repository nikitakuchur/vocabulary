import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import Style 1.0
import Units 1.0
import "../controls"

Controls.Page {
    property int expressionIndex: 0
    property var meanings

    id: root
    visible: false

    Flickable {
        anchors.fill: parent
        contentHeight: column.height + parent.height / 2
        Controls.ScrollBar.vertical: Controls.ScrollBar {}

        Column {
            id: column
            spacing: Units.dp(16)

            Text {
                text: qsTr("Expression")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                topPadding: Units.dp(16)
                leftPadding: Units.dp(16)
            }

            Text {
                width: root.width
                text: dictPage.model.get(expressionIndex).expression
                font.pixelSize: Style.font.size
                wrapMode: Text.Wrap
                leftPadding: Units.dp(16)
                rightPadding: Units.dp(16)
            }

            Line { width: root.width }

            Text {
                text: qsTr("Choose the meaning")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                leftPadding: Units.dp(16)
            }

            Repeater {
                model: meanings
                Button {
                    text: meanings[index]
                    font.pixelSize: Style.font.size
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Units.dp(16)
                }
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            expressionIndex = getRandomExpressionIndex();
            let meaningArray = getRandomMeanings();
            meaningArray.push(getRandomMeaning(expressionIndex));
            meaningArray = shuffle(meaningArray);
            meanings = meaningArray;
        }
    }

    function getRandomInt(count) {
        return Math.floor(Math.random() * count);
    }

    function getRandomExpressionIndex() {
        return getRandomInt(dictPage.model.count);
    }

    function getRandomMeaning(expressionIndex) {
        let meanings = dictPage.model.get(expressionIndex).meanings;
        let randomIndex = getRandomInt(meanings.count);
        return meanings.get(randomIndex).meaning;
    }

    function getRandomMeanings() {
        let result = [];
        for (let i = 0; i < 3; i++) {
            result.push(getRandomMeaning(getRandomExpressionIndex()));
        }
        return result;
    }

    function shuffle(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }
}
