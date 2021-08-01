import 'package:flutter/material.dart';
import 'package:ozzyschedule/AppBody.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Datebase/TaskHelper/TaskHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Task/Task.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';
import 'package:ozzyschedule/Screens/Task/DeleteTask.dart';
import 'package:ozzyschedule/Screens/Task/TaskDetail.dart';
import 'package:ozzyschedule/Screens/Task/add_task_page.dart';

class TaskList extends StatefulWidget {


  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {


  DbHelper dbHelper = new DbHelper();
  TaskHepler taskHepler = new TaskHepler();
  List<Task> tasks;
  int counter = 0;

  String active = "Active";
  String passive = "Passive";

  var firstvalue;
  String lastvalue;

  var statusColor;


 int _userId = int.tryParse("${SignInPageState.userId}") ;

  @override
  Widget build(BuildContext context) {

     if (tasks != null) {
      tasks.sort((a, b) => a.taskDate.compareTo(b.taskDate));
    }

    if (tasks == null) {
      tasks = new List<Task>();
      listTask();
    }

    return AppBody(
      body: Scaffold(
        body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: taskListItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child: AddTaskPage(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))));
              });
        },
        child: Icon(Icons.add),
      ),
    ));
  }

  ListView taskListItems() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        firstvalue = this.tasks[position].taskStatus.toString();
        if (firstvalue == "true") {
          lastvalue = active;
          statusColor=Colors.green;

        } else {
          lastvalue = passive;
          statusColor=Colors.red;
        }
        
        return Card(
            color: Color.fromRGBO(236, 240, 241, 1.0),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text(this.tasks[position].taskTitle[0]),
              ),
              title: Text(this.tasks[position].taskTitle),
              subtitle: Text(this.tasks[position].taskDescription),
              
              trailing: Text(
                lastvalue.toString(),
                style: TextStyle(color: statusColor),
              ),
              onTap: () {
                openTaskDetail(this.tasks[position]);
              },
              onLongPress: () {
                deleteTask(this.tasks[position]);
              },
            ));
      },
      itemCount: counter,
    );
  }

  void listTask() {
   
    
    try {
      var db = dbHelper.initializeDb();
      db.then((result) {
        var task = taskHepler.taskGetByUserId(_userId);
        task.then((data) {
          List<Task> taskData = new List<Task>();
          counter = data.length;
          for (var i = 0; i < counter; i++) {
            taskData.add(Task.fromObject(data[i]));
          }

          setState(() {
            tasks = taskData;
            counter = counter;
            print("Count of Listed Task : $counter");
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // void openTaskDetail(Task task) async {
  //   await Navigator.push(
  //       context, MaterialPageRoute(builder: (contex) => TaskDetail(task)));
  // }

  void openTaskDetail(Task task) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: TaskDetail(task),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))));
        });
  }

  void deleteTask(Task task) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: DeleteTask(task),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))));
        });
  }
}
