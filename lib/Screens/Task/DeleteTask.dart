import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/TaskHelper/TaskHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Task/Task.dart';
import 'package:ozzyschedule/widgets/custom_modal_delete_button.dart';

class DeleteTask extends StatefulWidget {
  Task task;
  DeleteTask(this.task);

  @override
  _DeleteTaskState createState() => _DeleteTaskState(task);
}

class _DeleteTaskState extends State<DeleteTask> {
  Task task;
  _DeleteTaskState(this.task);

  TextEditingController taskId;
  TextEditingController taskTitle;

  @override
  void initState() {
    super.initState();

    taskId = new TextEditingController(text: '${task.taskId}');
    taskTitle = new TextEditingController(text: '${task.taskTitle}');
    
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Delete This Task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          
          Text(
            "Are you sure you want to delete this task ?",
            
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            child: CustomModalDeleteButton(
              onClose: () {
                Navigator.of(context).pop();
              },
              onDelete: () {
                deleteTask();
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/TaskList');
              },
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

   void deleteTask() async {
     int id = int.parse("${taskId.text}");
    TaskHepler taskHepler = new TaskHepler();
    await taskHepler.deleteTask(id);
    
  }
}
