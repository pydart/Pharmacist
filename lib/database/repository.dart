import 'package:medicine/database/pills_database.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  PillsDatabase _pillsDatabase = PillsDatabase();
  static Database _database;

  //init database
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _pillsDatabase.setDatabase();
    return _database;
  }

  //insert something to database
  Future<int> insertData(String table, Map<String, dynamic> data) async {
    Database db = await database;
    try {
      return await db.insert(table, data);
    } catch (e) {
      return null;
    }
  }

  //get all data from database
  Future<List<Map<String, dynamic>>> getAllData(table) async {
    Database db = await database;
    try {
      return db.query(table);
    } catch (e) {
      return null;
    }
  }

  //delete data
  Future<int> deleteData(String table, int id) async {
    Database db = await database;
    try {
      return await db.delete(table, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      return null;
    }
  }

// Update some record
  Future<int> updateData(String table, int id, int done1, int done2,
      int doneAll, String type) async {
    Database db = await database;
    try {
      return await db.rawUpdate(
          'UPDATE $table SET done1 = ?, done2 = ?, doneAll = ?, type = ?  WHERE id = ?',
          [done1, done2, doneAll, '$type', id]);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
