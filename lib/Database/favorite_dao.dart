import 'package:project_pilot/database/database.dart';
import 'package:project_pilot/model/recipes.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDAO {
  static final String tableName = 'favorite_table';

  static final String createTable = '''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY,
        vegan INTEGER,
        title STRING,
        readyInMinutes INT,
        image STRING,
        summary STRING,
        aggregateLikes INT
      );
  ''';

  Future<int> insertFavorite(Recipes recipes) async {
    final db = await MyDatabase().getDatabase;
    final check = await db.insert(tableName, recipes.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return check;
  }

  Future<int> deleteFavorite(int id) async {
    final db = await MyDatabase().getDatabase;
    final check = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return check;
  }

  Future<int> deleteAllFavorite() async {
    final db = await MyDatabase().getDatabase;
    final check = await db.delete(tableName);
    return check;
  }

  Future<List<Recipes>> getAllFavorite() async {
    final db = await MyDatabase().getDatabase;
    List<Recipes> list = [];
    var result = await db.rawQuery('SELECT * FROM $tableName');
    if (result.isNotEmpty) {
      for (var json in result) {
        Recipes recipes = Recipes.fromDatabase(json);
        list.add(recipes);
      }
    }
    return list;
  }

  Future<List<int>> getAllID() async {
    final db = await MyDatabase().getDatabase;
    List<int> list = [];
    var result = await db.rawQuery('SELECT id FROM $tableName');
    if (result.isNotEmpty) {
      for (var json in result) {
        int id = json['id'] as int;
        list.add(id);
      }
    }
    return list;
  }
}
