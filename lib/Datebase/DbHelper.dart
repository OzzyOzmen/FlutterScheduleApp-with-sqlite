import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + " flutter_sqlite.db ";
    var dbsqlite = await openDatabase(path, version: 1, onCreate: _createDb);

    return dbsqlite;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  void _createDb(Database db, int version) async {
   
    await db.execute(
        "Create table Users(UserId integer primary key, UserName text, UserPassword text, UserFullName text, UserDayOfBirth text, UserPhoneNumber text, UserEmail text, UserGender text, UserPhoto text, UserStatus int)");
    await db.execute(
        "Create table Category(CategoryId integer primary key, CategoryName text)");
    await db.execute(
        "Create table Task(TaskId integer primary key,TaskCategory text, TaskTitle text, TaskDescription text, TaskDate text, TaskStatus text, UserId integer)");
    await db.execute(
        "Create table Event(EventId integer primary key,EventDescription text, EventCategory text, EventDate text, EventTime text, EventStatus text, UserId integer)");
     
  }

}
