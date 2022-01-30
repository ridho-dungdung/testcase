import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final table = 'my_table';
  static final dbVersion = 1;
  static final columnId = '_id';
  static final columnEmail = 'email';
  static final columnUsername = 'username';
  static final columnPassword = 'password';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database>get database async {
    if(_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MyDatabase.db");
    return await openDatabase(path,
        version: dbVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      create table $table (     
        $columnEmail text not null,
        $columnUsername text not null,
        $columnPassword text not null,
      )
    ''');
  }


  Future insert (Map<String, dynamic> row) async{
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future getAll()  async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT FROM $table')
    );
  }

}