import 'package:ozzyschedule/AppBody.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBody(
          body: Container(
        child: Text("Home Page"),
      )),
    );
  }
}
