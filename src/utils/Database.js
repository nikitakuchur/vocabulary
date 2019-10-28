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
    var meaningsStr = meanings.join('__,__');
    var db = getHandle();
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO vocabulary VALUES(?, ?)', [expression, meaningsStr]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    })
    return rowid;
}

function readAll()
{
    var db = getHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql('SELECT rowid, expression, meanings FROM vocabulary ORDER BY rowid DESC');
        for (var i = 0; i < results.rows.length; i++) {
            var meaningsArr = results.rows.item(i).meanings.split('__,__');
            var meanings = []
            for (var val of meaningsArr) {
                meanings.push({ meaning: val });
            }
            listModel.append({
                                 id: results.rows.item(i).rowid,
                                 expression: results.rows.item(i).expression,
                                 meanings: meanings
                             });
        }
    });
}

function update(rowid, expression, meanings)
{
    var meaningsStr = meanings.join('__,__');
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql('UPDATE vocabulary SET expression = ?, meanings = ? WHERE rowid = ?', [expression, meaningsStr, rowid]);
    })
}

function deleteRow(rowid)
{
    var db = getHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM vocabulary WHERE rowid = ?', [rowid]);
    });
}
