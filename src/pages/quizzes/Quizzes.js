.import "../../utils/Database.js" as DB

function hasMeaning(expression, meaning) {
    for (let val of expression.meanings) {
        if (val.meaning === meaning) {
            return true;
        }
    }
    return false;
}

function getRandomInt(count) {
    return Math.floor(Math.random() * count);
}

function getRandomElement(array) {
    return array[getRandomInt(array.length)];
}

function getRandomExpression() {
    let expressions = DB.readAll(dictList.get(currentDictIndex).id);
    return getRandomElement(expressions);
}

function getRandomLowLevelExpression() {
    let expressions = DB.getLowLevelExpressions(dictList.get(currentDictIndex).id);
    return getRandomElement(expressions);
}

function getRandomExpressions(initialExpression, count) {
    let result = [initialExpression];
    for (let i = 0; i < count; i++) {
        let randomExpression = getRandomExpression();
        if (!hasExpression(result, randomExpression)) {
            result.push(randomExpression);
        } else {
            i--;
        }
    }
    return result;
}

function hasExpression(expressions, expression) {
    for (let val of expressions) {
        if (val.expression === expression.expression) {
            return true;
        }
    }
    return false;
}

function getRandomMeanings(initialMeaning, count) {
    let result = [initialMeaning];
    for (let i = 0; i < count; i++) {
        let randomMeaning = getRandomElement(getRandomExpression().meanings).meaning;
        if (result.indexOf(randomMeaning) === -1) {
            result.push(randomMeaning);
        } else {
            i--;
        }
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

function increaseLevel(expression) {
    expression.level += 0.1;
    if (expression.level > 1) {
        expression.level = 1;
    }
    updateExpression(expression);
}

function decreaseLevel(expression) {
    expression.level -= 0.1;
    if (expression.level < 0) {
        expression.level = 0;
    }
    updateExpression(expression);
}

function updateExpression(expression) {
    let meanings = Qt.createQmlObject('import QtQuick 2.12; ListModel {}', parent);
    for (let val of expression.meanings) {
        meanings.append({ meaning: val.meaning });
    }
    DB.update(
        dictList.get(currentDictIndex).id,
        expression.id,
        expression.expression,
        meanings,
        expression.level
        );
}
