import 'package:flutter/material.dart';
import 'package:ozzyschedule/Screens/Task/add_task_page.dart';

class AddTask extends StatefulWidget {

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {


  @override
  Widget build(BuildContext context) {
    return Container(
       child: AddTaskPage(),
    );
  }
}