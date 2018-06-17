import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance  = new DatabaseHelper.internal();
  final String userTable;
  final String columnId = "id";
  final String columnUserName = "username";
  final String columnPassword = "password";


  factory DatabaseHelper()=> _instance;

  static Database _db;

  Future<Database>get db async{
    if(_db!=null){
      return _db;
    }
    _db = await initDb();
  }


  DatabaseHelper.internal();

  initDb() async {
    Directory documentosDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentosDirectory.path,"maindb.db");
    var myDb = await openDatabase(path,version: 1,onCreate: _onCreate);
  }



  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $userTable($columnId INTEGER PRIMARY KEY, $columnUserName TEXT,"
          "$columnPassword TEXT) "
    );
  }
}