function getHandle() {
    try {
        var db = LocalStorage.openDatabaseSync("Vocabulary_DB", "", "Vocabulary", 1000000);
    } catch (err) {
        console.log("Error opening database: " + err);
    }
    return db;
}

function createDict(dict) {
    dict = 'dict_' + dict;
    var db = getHandle();
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS ' + dict + ' (expression TEXT, meanings TEXT, level INTEGER)');
        })
    } catch (err) {
        console.log("Error creating table '" + dict + "' in database: " + err);
    };
}

function deleteDict(dict) {
    dict = 'dict_' + dict;
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE IF EXISTS ' + dict);
    });
}

function getDicts() {
    var db = getHandle();
    var tables = [];
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT name FROM sqlite_master WHERE type = "table"');
        for (var i = 0; i < result.rows.length; i++) {
            var name = result.rows.item(i).name;
            tables.push(name.slice(5, name.length));
        }
    });
    return tables;
}

function insert(dict, expression, meanings, level) {
    dict = 'dict_' + dict;
    var db = getHandle();
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO ' + dict + ' VALUES(?, ?, ?)',
                      [expression, meaningsToString(meanings), level]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    })
    return rowid;
}

function readAll(dict, model) {
    dict = 'dict_' + dict;
    model.clear();
    var db = getHandle();
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT rowid, expression, meanings, level FROM ' + dict + ' ORDER BY rowid DESC');
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

function update(dict, rowid, expression, meanings, level) {
    dict = 'dict_' + dict;
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('UPDATE ' + dict + ' SET expression = ?, meanings = ?, level = ? WHERE rowid = ?',
                      [expression, meaningsToString(meanings), level, rowid]);
    })
}

function deleteRow(dict, rowid) {
    dict = 'dict_' + dict;
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM ' + dict + ' WHERE rowid = ?', [rowid]);
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
