
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:ozzyschedule/Datebase/DbHelper.dart';

class CategoryHelper{


String tblCategory = "Category";
  String colCategoryId = "CategoryId";
  String colCategoryName ="CategoryName";

  Future<int> addCategory(Category category) async {
    Database db = await DbHelper().db;
    var result = await db.insert(tblCategory, category.toMap());
    return result;
  }

  Future<int> updateCategory(Category category) async {
    Database db = await DbHelper().db;
    var result = db.update(tblCategory, category.toMap(),
        where: "$colCategoryId =?", whereArgs: [category.categoryId]);
    return result;
  }

  Future<int> deleteCategory(int id) async {
    Database db = await DbHelper().db;
    var result= await db.rawDelete("Delete from $tblCategory where $colCategoryId=$id");
    return result;
  }

  Future<List> categoryGet() async {
    Database db = await DbHelper().db;
    var result = await db.rawQuery("Select * from $tblCategory");
    return result;

  }

}

