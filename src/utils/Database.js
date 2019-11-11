function init() {
    const db = getHandle();
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS dicts (name TEXT)');
        })
    } catch (err) {
        console.log("Error creating table dicts in database: " + err);
    };
}

function getHandle() {
    let db;
    try {
        db = LocalStorage.openDatabaseSync("Vocabulary_DB", "0.9", "Vocabulary", 1000000);
    } catch (err) {
        console.log("Error opening database: " + err);
    }
    return db;
}

function createDict(name) {
    const db = getHandle();
    let rowid = 0;
    try {
        db.transaction(function (tx) {
            tx.executeSql('INSERT INTO dicts VALUES(?)', [name]);
            rowid = tx.executeSql('SELECT last_insert_rowid()').insertId;
            tx.executeSql('CREATE TABLE IF NOT EXISTS dict' + rowid + ' (expression TEXT, meanings TEXT, level REAL)');
        })
    } catch (err) {
        console.log("Error creating dict in database: " + err);
    };
    return parseInt(rowid);
}

function deleteDict(id) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS dict' + id);
        tx.executeSql('DELETE FROM dicts WHERE rowid = ?', [id]);
    });
}

function renameDict(id, name) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('UPDATE dicts SET name = ? WHERE rowid = ?', [name, id]);
    });
}

function getDicts() {
    const db = getHandle();
    let dicts = [];
    db.transaction(function (tx) {
        let result = tx.executeSql('SELECT rowid, name FROM dicts ORDER BY rowid');
        for (let i = 0; i < result.rows.length; i++) {
            dicts.push({
                             id: result.rows.item(i).rowid,
                             name: result.rows.item(i).name
                         });
        }
    });
    return dicts;
}

function insert(dictId, expression, meanings, level) {
    const db = getHandle();
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO dict' + dictId + ' VALUES(?, ?, ?)', [expression, meaningsToString(meanings), level]);
        rowid = tx.executeSql('SELECT last_insert_rowid()').insertId;
    })
    return parseInt(rowid);
}

function readAll(dictId) {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const result = tx.executeSql('SELECT rowid, expression, meanings, level FROM dict' + dictId + ' ORDER BY rowid');
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                             id: result.rows.item(i).rowid,
                             expression: result.rows.item(i).expression,
                             meanings: stringToMeanings(result.rows.item(i).meanings),
                             level: result.rows.item(i).level
                         });
        }
    });
    return array;
}

function update(dictId, id, expression, meanings, level) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('UPDATE dict' + dictId + ' SET expression = ?, meanings = ?, level = ? WHERE rowid = ?',
                      [expression, meaningsToString(meanings), level, id]);
    });
}



function remove(dictId, id) {
    const db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM dict' + dictId + ' WHERE rowid = ?', [id]);
    });
}

function getLowLevelExpressions(dictId) {
    const db = getHandle();
    let array = [];
    db.transaction(function (tx) {
        const minLevel = tx.executeSql('SELECT min(level) as minLevel FROM dict' + dictId).rows.item(0).minLevel;
        const result = tx.executeSql('SELECT  rowid, expression, meanings, level FROM dict' + dictId + ' WHERE level BETWEEN ? AND ?',
                                     [minLevel, (minLevel + 0.2)]);
        for (let i = 0; i < result.rows.length; i++) {
            array.push({
                           id: result.rows.item(i).rowid,
                           expression: result.rows.item(i).expression,
                           meanings: stringToMeanings(result.rows.item(i).meanings),
                           level: result.rows.item(i).level
                       });
        }
    });
    return array;
}

function meaningsToString(meanings) {
    let str = "";
    const separator = '__,__';
    for (let i = 0; i < meanings.count; i++) {
        str += meanings.get(i).meaning + separator;
    }
    str = str.slice(0, -separator.length);
    return str;
}

function stringToMeanings(str) {
    let array = str.split('__,__');
    let meanings = [];
    for (let val of array) {
        meanings.push({ meaning: val });
    }
    return meanings;
}
