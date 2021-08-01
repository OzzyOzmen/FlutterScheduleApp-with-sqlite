import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Models/Users/Users.dart';

class UserHelper {
  String tblUsers = "Users";
  String colUserId = "UserId";
  String colUserName = "UserName";
  String colUserPassword = "UserPassword";
  String colUserFullName = "UserFullName";
  String colUserPhoneNumber = "UserPhoneNumber";
  String colUserEmail = "UserEmail";
  String colUserGender = "UserGender";
  String colUserPhoto = "UserPhoto";
  String colUserStatus = "UserStatus";

  Future<int> addUser(Users user) async {
    Database db = await DbHelper().db;
    var result = await db.insert(tblUsers, user.toMap());
    return result;
  }

  Future<int> updateUser(Users user) async {
    Database db = await DbHelper().db;
    var result = db.update(tblUsers, user.toMap(),
        where: "$colUserId =?", whereArgs: [user.userId]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    Database db = await DbHelper().db;
    var result = db.rawDelete("Delete * from $tblUsers where $colUserId=$id");
    return result;
  }

  Future<List> getUser() async {
    Database db = await DbHelper().db;
    var result = await db.rawQuery("Select * from $tblUsers");
    return result;
  }

  
}
