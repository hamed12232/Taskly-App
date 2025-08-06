import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "7aamed.db");
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
    return mydb;
  }

  _onCreate(Database db, int Version) async {
    await db.execute('''
CREATE TABLE "Notes" (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  subtitle TEXT NOT NULL,
  color INTEGER NOT NULL,
  date TEXT NOT NULL

)

    ''');
    await db.execute('''
CREATE TABLE "Favourite" (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  subtitle TEXT NOT NULL,
  color INTEGER NOT NULL,
  date TEXT NOT NULL

)

    ''');
    print("Create db and Table **********************************");
  }

//SELECT
  readData(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insertData(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  updateData(String table, Map<String, Object?> values, String where,
      List<Object?>? whereArgs) async {
    Database? mydb = await db;
    int response =
        await mydb!.update(table, values, where: where, whereArgs: whereArgs);
    return response;
  }

  deleteData(String table, String myWhere, List<Object?>? whereArgs) async {
    Database? mydb = await db;
    int response =
        await mydb!.delete(table, where: myWhere, whereArgs: whereArgs);
    return response;
  }

  mydeleteDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "hamed.db");
    await deleteDatabase(path);
  }
}
