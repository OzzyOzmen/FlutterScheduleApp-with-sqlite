import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ozzyschedule/Datebase/CategoryHelper.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Datebase/TaskHelper/TaskHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:ozzyschedule/Models/Schedule/Task/Task.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';
import 'package:ozzyschedule/widgets/custom_date_time_picker.dart';
import 'package:ozzyschedule/widgets/custom_modal_action_button.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String _taskCategory;
  String _taskTitle;
  String _taskDescription;
  DateTime _taskDate = DateTime.now();
  bool _taskStatus = true;

  int counter = 0;

  List<String> categories;

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null)
      setState(() {
        _taskDate = datepick;
      });
  }

  int _userId = int.tryParse("${SignInPageState.userId}");
  
  @override
  Widget build(BuildContext context) {
    if (categories == null) {
      categories = new List<String>();
      listCategories();
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Add new task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Task Title',
              labelText: 'Task Title',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              setState(() {
                _taskTitle = value;
              });
            },
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Task Description',
                labelText: 'Task Description',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                setState(() {
                  _taskDescription = value;
                });
              }),
          new Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 12, left: 0),
                  child: Icon(Icons.assignment, color: Colors.red, size: 30)),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 12, bottom: 15),
                child: DropdownButton(
                  value: _taskCategory,
                  items: categories.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (d) {
                    setState(() {
                      _taskCategory = d;
                    });
                  },
                ),
              )
            ],
          ),
          CustomDateTimePicker(
            icon: Icons.date_range,
            onPressed: _pickDate,
            value: new DateFormat("dd-MM-yyyy").format(_taskDate),
          ),
          new Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 12, left: 0),
                  child: Icon(Icons.spellcheck, color: Colors.red, size: 30)),
              Container(
                  padding: const EdgeInsets.only(top: 15, left: 12, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      CupertinoSwitch(
                        activeColor: Colors.green,
                        value: _taskStatus,
                        onChanged: (value) {
                          print("VALUE : $value");
                          setState(() {
                            _taskStatus = value;
                          });
                        },
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            child: CustomModalActionButton(
              onClose: () {
                Navigator.of(context).pop();
              },
              onSave: () {
                addTask();
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/TaskList');
              },
            ),
          )
        ],
      ),
    );
  }

  void addTask() async {
    TaskHepler todoHepler = new TaskHepler();
    Task task = new Task(_taskCategory, _taskTitle, _taskDescription,
        _taskDate.toString(), _taskStatus.toString(),_userId);
    try {
      if (_taskCategory != null &&
          _taskTitle != null &&
          _taskDescription != null &&
          _taskDate != null &&
          _taskStatus != null) {
        await todoHepler.addTask(task);
      } else {
        fieldError();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> fieldError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ups !! Incomplete required fields ',
              style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    ' Please make sure all required fields are filled out correctly'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void listCategories() {
    DbHelper dbHelper = new DbHelper();
    CategoryHelper categoryHelper = new CategoryHelper();

    try {
      var db = dbHelper.initializeDb();
      db.then((result) {
        var task = categoryHelper.categoryGet();
        task.then((data) {
          List<String> categoryData = new List<String>();
          counter = data.length;
          for (var i = 0; i < counter; i++) {
            categoryData
                .add(Category.fromObject(data[i]).categoryName.toString());
          }

          setState(() {
            categories = categoryData;
            _taskCategory = categories[0];
            counter = counter;
            print("Count of Listed Category : $counter");
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
