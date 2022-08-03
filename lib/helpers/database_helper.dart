import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final usertable = 'user';
  static final messagetable = 'messages';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnImage = 'image';

  static final columnIdmessage = '_id';
  static final columnmessage = 'message';
  static final columnsenderid = 'senderid';
  static final columnreceiverid = 'receiverid';
  static final columnuserid = 'userid';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $usertable ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT NOT NULL, $columnImage TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE $messagetable ($columnIdmessage INTEGER PRIMARY KEY AUTOINCREMENT, $columnmessage TEXT NOT NULL, $columnsenderid INTEGER NOT NULL, $columnreceiverid INTEGER NOT NULL, $columnuserid INTEGER NOT NULL)');
  }

  Future<int> insert(Map<String, dynamic> row, tablename) async {
    Database db = await instance.database;
    return await db.insert(tablename, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(tablename) async {
    Database db = await instance.database;
    return await db.query(tablename);
  }
}
