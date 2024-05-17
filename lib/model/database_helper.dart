import 'package:d20flutter_new/model/roll.dart';
import 'package:d20flutter_new/model/roll_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "DiceDatabase.db";
  static const _databaseVersion = 1;
  static const rollTable = "roll";
  static const rollGroupTable = "roll_group";
  static const columnId = "id";
  static const rollGroupId = "roll_group_id";
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
    return openDatabase(path, version: _databaseVersion, onOpen: _onOpen, onCreate: _onCreate);
  }

  static Future _onOpen(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $rollGroupTable (
      $columnId String PRIMARY KEY,
      $columnCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    )
    ''');
    await db.execute('''
    CREATE TABLE $rollTable (
      $columnId STRING PRIMARY KEY,
      $columnCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      $columnDie INTEGER NOT NULL,
      $columnSide INTEGER NOT NULL
      $rollGroupId STRING,
      FOREIGN KEY ($rollGroupId) REFERENCES $rollGroupTable($columnId)
      ON DELETE CASCADE
    )
    ''');
  }

  static Future addRoll(RollModel rollModel) async {
    Database db = await _database;

    final rollGroup = rollModel.toRollGroup().toMap();
    final rolls = rollModel.toRolls().map((roll) => roll.toMap()).toList();

    await db.insert(rollGroupTable, rollGroup);
    for (final roll in rolls) {
      await db.insert(rollTable, roll);
    }
  }

  static Future<List<RollModel>> getAllRolls() async {
    final Database db = await _database;

    final List<Map<String, dynamic>> rollMaps = await db.query(DatabaseHelper.rollTable);
    final rolls = rollMaps.map((rollMap) => Roll.fromMap(rollMap));
    final rollsIndex = <String, List<Roll>>{};
    for (final roll in rolls) {
      if (rollsIndex[roll.rollGroupId] == null) {
        rollsIndex[roll.rollGroupId] = List.empty(growable: true);
      }
      rollsIndex[roll.rollGroupId]!.add(roll);
    }
    return rollsIndex.values
        .map((roll) => RollModel(0, 0) // TODO: Recreate teh roll model
            )
        .toList();
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
