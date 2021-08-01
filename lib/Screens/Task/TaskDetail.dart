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

class TaskDetail extends StatefulWidget {
  Task task;
  TaskDetail(this.task);
  @override
  _TaskDetailState createState() => _TaskDetailState(task);
}

class _TaskDetailState extends State<TaskDetail> {
  Task task;
  _TaskDetailState(this.task);

  String _taskCategory;

  String _taskTitle;
  String _taskDescription;
  DateTime _taskDate;
  bool _taskStatus;

    int counter = 0;

  List<String> categories;

  TextEditingController taskId;
  TextEditingController taskCategory;
  TextEditingController taskTitle;
  TextEditingController taskDescription;
  TextEditingController taskDate;
  TextEditingController taskStatus;
  TextEditingController userId;

  @override
  void initState() {
    super.initState();

    taskId = new TextEditingController(text: '${task.taskId}');
    taskCategory = new TextEditingController(text: '${task.taskCategory}');
    taskTitle = new TextEditingController(text: '${task.taskTitle}');
    taskDescription =
        new TextEditingController(text: '${task.taskDescription}');
    taskDate = new TextEditingController(text: '${task.taskDate}');
    taskStatus = new TextEditingController(text: '${task.taskStatus}');


    if (taskCategory != null) {
      _taskCategory = task.taskCategory;
    } else {
      _taskCategory = _taskCategory;
    }
    if (taskTitle != null) {
      _taskTitle = task.taskTitle;
    }
    if (taskDescription != null) {
      _taskDescription = task.taskDescription;
    }

    var parsedDate = DateTime.parse(taskDate.text);
    if (taskDate.text != null) {
      _taskDate = parsedDate;
    } else {
      _taskDate = DateTime.now();
    }

    if (taskStatus.text == "true") {
      _taskStatus = true;
    }
    if (taskStatus.text == "false") {
      _taskStatus = false;
    }
  }

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null) {
      setState(() {
        _taskDate = datepick;
      });
    } else {
      setState(() {
        datepick = _taskDate;
      });
    }
  }
  int _userId = int.tryParse("${SignInPageState.userId}") ;
  

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
            "Task Detail",
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
            controller: taskTitle,
            keyboardType: TextInputType.text,
            onChanged: (d) {
              setState(() {
                _taskTitle = d;
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
            controller: taskDescription,
            keyboardType: TextInputType.text,
            onChanged: (d) {
              setState(() {
                _taskDescription = d;
              });
            },
          ),
          new Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 12, left: 0),
                  child: Icon(Icons.assignment, color: Colors.red, size: 30)),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 12, bottom: 15),
                child: DropdownButton(
                  value: _taskCategory,
                  items: categories
                      .map((String value) {
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
          CustomModalActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              updateTask();
              Navigator.of(context).pop();
              Navigator.popAndPushNamed(context, '/TaskList');
            },
          )
        ],
      ),
    );
  }

  void updateTask() async {
    try {
      
      int _taskId = int.parse("${taskId.text}");
  
      TaskHepler taskHelper = new TaskHepler();
      Task task = Task.byId(_taskId, _taskCategory, _taskTitle,
          _taskDescription, _taskDate.toString(), _taskStatus.toString(),_userId);
      await taskHelper.updateTask(task);
    } catch (e) {
      e.toString();
    }
  }

void listCategories() {
    DbHelper dbHelper = new DbHelper();
    CategoryHelper categoryHelper = new CategoryHelper();

    try {
      var db = dbHelper.initializeDb();
      db.then((result) {
        var task = categoryHelper.categoryGet();
        task.then((data) {
          List<String>categoryData = new List<String>();
          counter = data.length;
          for (var i = 0; i < counter; i++) {
            categoryData
                .add(Category.fromObject(data[i]).categoryName.toString());
          }

          setState(() {
            categories = categoryData;
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
