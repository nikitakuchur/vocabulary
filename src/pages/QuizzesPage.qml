import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import Style 1.0
import Units 1.0
import "../controls"
import "quizzes"
import "quizzes/Quizzes.js" as QZ

Controls.Page {
    id: root
    visible: false

    MeaningQuiz {
        id: meaningQuiz
        visible: false
    }

    ExpressionQuiz {
        id: expressionQuiz
        visible: false
    }

    Timer {
        id: timer
        interval: 500
        onTriggered: stack.replace("qrc:/pages/QuizzesPage.qml")
    }

    onVisibleChanged: {
        if (visible) {
            if (QZ.getRandomInt(2) === 0) {
                meaningQuiz.visible = true;
            } else {
                expressionQuiz.visible = true
            }
        }
    }
}
