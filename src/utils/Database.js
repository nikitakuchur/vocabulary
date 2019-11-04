function init() {
    var db = getHandle();
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS dicts (name TEXT)');
        })
    } catch (err) {
        console.log("Error creating table dicts in database: " + err);
    };
}

function getHandle() {
    try {
        var db = LocalStorage.openDatabaseSync("Vocabulary_DB", "", "Vocabulary", 1000000);
    } catch (err) {
        console.log("Error opening database: " + err);
    }
    return db;
}

function createDict(name) {
    var db = getHandle();
    var rowid = 0;
    try {
        db.transaction(function (tx) {
            tx.executeSql('INSERT INTO dicts VALUES(?)', [name]);
            rowid = tx.executeSql('SELECT last_insert_rowid()').insertId;
            tx.executeSql('CREATE TABLE IF NOT EXISTS dict' + rowid + ' (expression TEXT, meanings TEXT, level INTEGER)');
        })
    } catch (err) {
        console.log("Error creating dict in database: " + err);
    };
    return parseInt(rowid);
}

function deleteDict(id) {
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS dict' + id);
        tx.executeSql('DELETE FROM dicts WHERE rowid = ?', [id]);
    });
}

function getDicts(model) {
    var db = getHandle();
    var dicts = [];
    model.clear();
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT rowid, name FROM dicts ORDER BY rowid ASC');
        for (var i = 0; i < result.rows.length; i++) {
            model.append({
                             id: result.rows.item(i).rowid,
                             name: result.rows.item(i).name
                         });
        }
    });
}

function insert(dictId, expression, meanings, level) {
    var db = getHandle();
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO dict' + dictId + ' VALUES(?, ?, ?)', [expression, meaningsToString(meanings), level]);
        rowid = tx.executeSql('SELECT last_insert_rowid()').insertId;
    })
    return parseInt(rowid);
}

function readAll(dictId, model) {
    model.clear();
    var db = getHandle();
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT rowid, expression, meanings, level FROM dict' + dictId + ' ORDER BY rowid ASC');
        for (var i = 0; i < result.rows.length; i++) {
            model.append({
                             id: result.rows.item(i).rowid,
                             expression: result.rows.item(i).expression,
                             meanings: stringToMeanings(result.rows.item(i).meanings),
                             level: result.rows.item(i).level
                         });
        }
    });
}

function update(dictId, id, expression, meanings, level) {
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('UPDATE dict' + dictId + ' SET expression = ?, meanings = ?, level = ? WHERE rowid = ?',
                      [expression, meaningsToString(meanings), level, id]);
    })
}

function deleteRow(dictId, id) {
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM dict' + dictId + ' WHERE rowid = ?', [id]);
    });
}

function meaningsToString(meanings) {
    var str = "";
    var separator = '__,__';
    for (var i = 0; i < meanings.count; i++) {
        str += meanings.get(i).meaning + separator;
    }
    str = str.slice(0, -separator.length);
    return str;
}

function stringToMeanings(str) {
    var array = str.split('__,__');
    var meanings = [];
    for (var val of array) {
        meanings.push({ meaning: val });
    }
    return meanings;
}
