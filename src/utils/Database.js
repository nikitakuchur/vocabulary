function init()
{
    var db = LocalStorage.openDatabaseSync("Vocabulary_DB", "", "Vocabulary", 1000000);
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS vocabulary (expression text, meanings text)');
        })
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function getHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Vocabulary_DB", "", "Vocabulary", 1000000);
    } catch (err) {
        console.log("Error opening database: " + err);
    }
    return db;
}

function insert(expression, meanings)
{
    var db = getHandle();
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO vocabulary VALUES(?, ?)', [expression, meaningsToString(meanings)]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    })
    return rowid;
}

function readAll(model)
{
    model.clear();
    var db = getHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql('SELECT rowid, expression, meanings FROM vocabulary ORDER BY rowid DESC');
        for (var i = 0; i < results.rows.length; i++) {
            model.append({
                                 id: results.rows.item(i).rowid,
                                 expression: results.rows.item(i).expression,
                                 meanings: stringToMeanings(results.rows.item(i).meanings)
                             });
        }
    });
}

function update(rowid, expression, meanings)
{
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('UPDATE vocabulary SET expression = ?, meanings = ? WHERE rowid = ?', [expression, meaningsToString(meanings), rowid]);
    })
}

function deleteRow(rowid)
{
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM vocabulary WHERE rowid = ?', [rowid]);
    });
}

function meaningsToString(meanings) {
    var str = "";
    var separator = '__,__'
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
