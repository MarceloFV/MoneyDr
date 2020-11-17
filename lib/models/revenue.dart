import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

enum RevenueType {
  Profit,
  Expense,
}

class Revenue {
  int id;
  String title;
  String description;
  // String category;
  RevenueType type;
  DateTime time;
  num value;

  Revenue({
    this.id,
    this.title = "",
    this.description = "",
    this.type = RevenueType.Expense,
    this.time,
    this.value = 0,
  });

  Revenue.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        type = (json['type'] == 1) ? RevenueType.Profit : RevenueType.Expense,
        time = DateTime.fromMillisecondsSinceEpoch(json['time']),
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'type': (type == RevenueType.Profit) ? 1 : 0,
        'time': time.millisecondsSinceEpoch,
        'value': value,
      };

  @override
  String toString() {
    return "Revenue: {title: $title, desc: $description, type: $type, time: $time, value: $value}";
  }
}

class RevenueHelper {
  RevenueDataBase dataBase = RevenueDataBase.instance;

  
  Future<List<Revenue>> get revenues async {
    List<Map<String, dynamic>> list = await dataBase.queryAllRows();
    return list.map((json) => Revenue.fromJson(json)).toList();
  }

  Future<int> addRevenue(Revenue revenue) {
    return dataBase.insert(revenue.toJson());
  }
}

class RevenueDataBase {
  static final _databaseName = "MoneyData.db";
  static final _databaseVersion = 1;

  static final table = 'revenues_table';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnType = 'type';
  static final columnTime = 'time';
  static final columnValue = 'value';

  /// make this a singleton class
  RevenueDataBase._privateConstructor();
  static final RevenueDataBase instance = RevenueDataBase._privateConstructor();

  /// only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    // lazily instantiate the db the first time it is accessed
    return await _initDatabase();
  }

  /// this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnType INT NOT NULL,
            $columnTime INT NOT NULL,
            $columnValue REAL NOT NULL
          )
          ''');
  }

  Future dropDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, _databaseName);
    await deleteDatabase(path);
    // return await dropDa
  }

  // Helper methods

  /// Inserts a row in the database where each key in the Map is a column name
  /// and the value is the column value. The return value is the id of the
  /// inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  /// All of the rows are returned as a list of maps, where each map is
  /// a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  /// All of the methods (insert, query, update, delete) can also be done using
  /// raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  /// We are assuming here that the id column in the map is set. The other
  /// column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Deletes the row specified by the id. The number of affected rows is
  /// returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
