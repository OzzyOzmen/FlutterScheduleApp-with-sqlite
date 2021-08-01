import 'package:flutter/cupertino.dart';
import 'package:ozzyschedule/Screens/Event/add_event_page.dart';

class AddEvent extends StatefulWidget {

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: AddEventPage(),
    );
  }
}