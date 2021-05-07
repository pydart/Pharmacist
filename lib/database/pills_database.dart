import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PillsDatabase {
  setDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "pills_db");
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Pills (id INTEGER PRIMARY KEY, name TEXT, amount TEXT, type TEXT, howManyWeeks INTEGER, medicineForm TEXT, time INTEGER, notifyId INTEGER, name2 TEXT, amount2 TEXT, done1 INTEGER, done2 INTEGER, doneAll INTEGER, hour INTEGER, min INTEGER)");
    });
    return database;
  }
}
