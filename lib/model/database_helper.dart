import 'package:d20flutter_new/model/roll.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "DiceDatabase.db";
  static const _databaseVersion = 1;
  static const rollTable = "roll";
  static const columnId = "id";
  static const columnCreatedAt = "created_at";
  static const columnDie = "die";
  static const columnSide = "side";

  static Database? _databaseStorage;
  static Future<Database> get _database async {
    if (_databaseStorage != null) return _databaseStorage!;
    _databaseStorage = await _initDatabase();
    return _databaseStorage!;
  }

  static _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print(path);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $rollTable (
      $columnId INTEGER PRIMARY KEY,
      $columnCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      $columnDie INTEGER NOT NULL,
      $columnSide INTEGER NOT NULL
    )
    ''');
  }

  static Future addRoll(int die, int side) async {
    Database db = await _database;

    Map<String, dynamic> roll = {
      columnDie: die,
      columnSide: side,
    };
    return await db.insert(rollTable, roll);
  }

  static Future<List<Roll>> getAllRolls() async {
    final Database db = await _database;

    final List<Map<String, dynamic>> maps = await db.query(DatabaseHelper.rollTable);
    return List.generate(maps.length, (i) {
      return Roll.fromMap(maps[i]);
    });
  }

  Future<void> deleteOldDices() async {
    final Database db = await _database;

    // First, find the created_at of the 100th oldest dice
    String find100thDiceQuery = '''
    SELECT $columnCreatedAt FROM $rollTable ORDER BY $columnCreatedAt DESC LIMIT 1 OFFSET 99
    ''';
    var oldestAllowedDice = await db.rawQuery(find100thDiceQuery);
    if (oldestAllowedDice.isEmpty) return;
    String timestamp = oldestAllowedDice.first[columnCreatedAt] as String;

    // Now, delete all dices older than the 100th dice
    String deleteQuery = '''
    DELETE FROM $rollTable WHERE $columnCreatedAt < ?
    ''';
    await db.rawDelete(deleteQuery, [timestamp]);
  }
}
