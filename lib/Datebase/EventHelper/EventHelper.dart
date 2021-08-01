import 'package:ozzyschedule/Models/Schedule/Events/Event.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:ozzyschedule/Datebase/DbHelper.dart';

class EventHelper {
  String tblEvent = "Event";
  String colEventId = "EventId";
  String colEventCategory = "EventCategory";
  String colEventDescription = "EventDescription";
  String colEventDate = "EventDate";
  String colEventTime = "EventTime";
  String colEventStatus = "EventStatus";
  String colUserId = "UserId";

  Future<int> addeEvent(Event task) async {
    Database db = await DbHelper().db;
    var result = await db.insert(tblEvent, task.toMap());
    return result;
  }

  Future<int> updateEvent(Event event) async {
    Database db = await DbHelper().db;
    var result = await db.update(tblEvent, event.toMap(),
        where: "$colEventId =?", whereArgs: [event.eventId]);
    return result;
  }

  Future<int> deleteEvent(int id) async {
    Database db = await DbHelper().db;
    var result =
        await db.rawDelete("Delete from $tblEvent where $colEventId= $id");
    return result;
  }

  Future<List> eventGet() async {
    Database db = await DbHelper().db;
    var result = await db.rawQuery("Select * from $tblEvent");
    return result;
  }

  Future<List> eventGetById(int id) async {
    Database db = await DbHelper().db;
    var result =
        await db.rawQuery("Select * from $tblEvent where $colEventId= $id");
    return result;
  }

  Future<List> eventGetByUserId(int id) async {
    Database db = await DbHelper().db;
    var result =
        await db.rawQuery("Select * from $tblEvent where $colUserId= $id");
    return result;
  }
}
