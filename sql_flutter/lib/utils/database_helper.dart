import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_flutter/models/user.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance  = new DatabaseHelper.internal();
  final String userTable = "users";
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
    return _db;
  }


  DatabaseHelper.internal();

  initDb() async {
    Directory documentosDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentosDirectory.path,"maindb.db");
    var myDb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return myDb;
  }



  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $userTable($columnId INTEGER PRIMARY KEY, $columnUserName TEXT,"
          "$columnPassword TEXT) "
    );
  }


  //Insertion
Future<int> addUser(User user)async {
  var dbCliente = await db;

  int res = await dbCliente.insert(userTable, user.toMap());
  return res;
  }

Future<List> getAllUsers() async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $userTable");
    return result;
}

Future<int> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $userTable"));
}

Future<User> getUser(int id)async{
    var dbClient = await db;
    var userList = await dbClient.rawQuery("SELECT * FROM $userTable WHERE $columnId = $id");

    if (userList.length==0) return null;
    return new User.fromMap(userList.first);
}

Future<int> deleteUser(int id)async{
    var dbClient = await db;
    return await dbClient.delete(userTable,where: "$columnId = ?",whereArgs: [id]);
}

Future<int> updateUser(User user, int id)async{
    var dbClient = await db;
    return await dbClient.update(userTable, user.toMap(),where: "$columnId =?",whereArgs: [id]);
}

  Future<int> updateUserFromMap(User user)async{
    var dbClient = await db;
    return await dbClient.update(userTable, user.toMap(),where: "$columnId =?",whereArgs: [user.id]);
  }

Future close()async{
    var dbClient = await db;
    return dbClient.close();
}

  Future clearDb()async{
    var dbClient = await db;
    return dbClient.rawDelete("DELETE FROM $userTable");
}


}