import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import Units 1.0
import Style 1.0
import "../../controls"
import "../../utils/Quizzes.js" as QZ

Flickable {
    property int expressionIndex: 0
    property variant meanings

    anchors.fill: parent
    contentHeight: column.height + parent.height * 0.2
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
            id: repeater
            model: meanings
            Button {
                text: meanings[index]
                font.pixelSize: Style.font.size
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Units.dp(16)

                onClicked: {
                    if (QZ.hasMeaning(expressionIndex, meanings[index])) {
                        defaultColor = Material.color(Material.Green);
                    } else {
                        defaultColor = Material.color(Material.Pink);
                    }
                    for (let i = 0; i < repeater.count; i++) {
                        repeater.itemAt(i).enabled = false;
                    }
                    timer.start();
                }
            }
        }

        onVisibleChanged: {
            if (visible) {
                expressionIndex = QZ.getRandomExpressionIndex();
                let array = QZ.getRandomMeanings(QZ.getRandomMeaning(expressionIndex), 3);
                meanings = QZ.shuffle(array);
            }
        }
    }
}
