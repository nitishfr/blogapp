import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "MyBlogs.db";
  static final _databaseVersion = 1;

  static final table = 'blogs';

  static final columnId = '_id';
  static final columnTitle = 'title';
  static final columnImg = 'img';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database1 async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
          
            $columnImg TEXT NOT NULL ,
              $columnTitle TEXT NOT NULL 
            
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;

    return await db.query(table);
  }

  Future<bool> queryData(String query) async {
    Database db = await instance.database;
    var data = await db.rawQuery('SELECT * FROM $table where _id = "${query}" ');

    return data.length != 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;

    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '_id = ?', whereArgs: [id]);
  }
}
