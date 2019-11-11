function hasMeaning(expressionIndex, meaning) {
    let currentMeanings = dictPage.model.get(expressionIndex).meanings;
    for (let i = 0; i < currentMeanings.count; i++) {
        if (currentMeanings.get(i).meaning === meaning) {
            return true;
        }
    }
    return false;
}

function getRandomInt(count) {
    return Math.floor(Math.random() * count);
}

function getRandomExpressionIndex() {
    return getRandomInt(dictPage.model.count);
}

function getRandomExpressionIndicies(initialExpression, count) {
    let result = [initialExpression];
    for (let i = 0; i < count; i++) {
        let randomExpression = getRandomExpressionIndex();
        if (result.indexOf(randomExpression) === -1) {
            result.push(randomExpression);
        } else {
            i--;
        }
    }
    return result;
}

function getRandomMeaning(expressionIndex) {
    let meanings = dictPage.model.get(expressionIndex).meanings;
    let randomIndex = getRandomInt(meanings.count);
    return meanings.get(randomIndex).meaning;
}

function getRandomMeanings(initialMeaning, count) {
    let result = [initialMeaning];
    for (let i = 0; i < count; i++) {
        let randomMeaning = getRandomMeaning(getRandomExpressionIndex());
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
