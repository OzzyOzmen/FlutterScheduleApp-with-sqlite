import 'package:ozzyschedule/Models/Schedule/Task/Task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:ozzyschedule/Datebase/DbHelper.dart';

class TaskHepler {
  String tblTask = "Task";
  String colTaskId = "TaskId";
  String colTaskCategory = "TaskCategory";
  String colTaskTitle = "TaskTitle";
  String colTaskDescription = "TaskDescription";
  String colTaskDate = "TaskDate";
  String colTaskStatus = "TaskStatus";
  String colUserId = "UserId";

  Future<int> addTask(Task task) async {
    Database db = await DbHelper().db;
    var result = await db.insert(tblTask, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await DbHelper().db;
    var result = await db.update(tblTask, task.toMap(),
        where: "$colTaskId =?", whereArgs: [task.taskId]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await DbHelper().db;
    var result =
        await db.rawDelete("Delete from $tblTask where $colTaskId= $id");
    return result;
  }

  Future<List> taskGet() async {
    Database db = await DbHelper().db;
    var result = await db.rawQuery("Select * from $tblTask");
    return result;
  }

  Future<List> taskGetById(int id) async {
    Database db = await DbHelper().db;
    var result =
        await db.rawQuery("Select * from $tblTask where $colTaskId= $id");
    return result;
  }

  Future<List> taskGetByUserId(int id) async {
    Database db = await DbHelper().db;
    var result =
        await db.rawQuery("Select * from $tblTask where $colUserId= $id");
    return result;
  }
}
