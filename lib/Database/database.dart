import 'package:path/path.dart';
import 'package:project_pilot/database/favorite_dao.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static final databaseName = 'recipes.db';
  Database? _database;

  MyDatabase();

  Future<Database> get getDatabase async {
    if (_database == null) {
      return _database = await openDB();
    } else {
      return _database!;
    }
  }

  Future<Database> openDB() async {
    return _database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        db.execute(FavoriteDAO.createTable);
      },
      version: 1,
    );
  }
}
