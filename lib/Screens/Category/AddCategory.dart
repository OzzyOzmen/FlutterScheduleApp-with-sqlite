import 'package:flutter/cupertino.dart';
import 'package:ozzyschedule/Screens/Category/add_category_page.dart';

class AddEvent extends StatefulWidget {
  AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: AddCategoryPage(),
    );
  }
}