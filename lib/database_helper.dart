import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'item_model.dart';

class DatabaseHelper {
  static final String DB_NAME = 'demo.db';
  static final int DB_VERSION = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDataBase();
    }
    return _database!;
  }

  Future<Database> _initDataBase() async {
    final db_Path = await getDatabasesPath();
    final path = await join(db_Path, DB_NAME);
    return await openDatabase(path, version: DB_VERSION, singleInstance: true,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)");
    });
  }

  //insert
  Future<int> insertData(Note note) async {
    final db = await database;
    //in future map should be From UI  data,UiMap['title']...
    int rowId = await db.insert("note", note.toMap());
    return rowId;
  }

  Future<List<Note>> fetchData() async {
    //returns List<Map<String, dynamic>>mapList=db.query();
    final db = await database;
    final mapList = await db.rawQuery('SELECT * FROM note');
    //convert this mapList to NoteList to use it in UI
    //This code creates a new list of Note objects based on an existing list of maps (maps).
    return List.generate(mapList.length, (i) => Note.fromMap(mapList[i]));
  }

  //update()
  Future<int> updateData(Note note) async {
    final db = await database;
    int updatedRow = await db
        .update("note", note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return updatedRow;
  }

//delete
  Future<int> deleteData(int id) async {
    final db = await database;
    int deletedRow = await db.rawDelete('DELETE FROM note WHERE id = ?', [id]);

    return deletedRow;
  }

  //get no of row in db
  Future<int> countRow() async {
    final db = await database;
    var lists = await db.rawQuery('SELECT COUNT(*) FROM note');
    int? count = Sqflite.firstIntValue(lists) ?? 0;
    return count;
  }
//insert data into database
//insert(“tablename”,Map);
// what are methods for crud operaions in sqflite in flutter
//database.query('users'),delete(),update('users', {'name': 'Jane Doe'}, where: 'id = ?', whereArgs: [1]);

//get refrence to db
//execute CRUD operations
//on Model
//call to Model methods
//where to get db reference
//where to open db in flutter sqflite

//now GetxController and getter and setter functions
}
