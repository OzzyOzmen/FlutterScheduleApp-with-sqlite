import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/CategoryHelper.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Datebase/EventHelper/EventHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Category.dart';
import 'package:ozzyschedule/Models/Schedule/Events/Event.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';
import 'package:ozzyschedule/widgets/custom_date_time_picker.dart';
import 'package:ozzyschedule/widgets/custom_modal_action_button.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  String _eventDescription;
  int _userId = int.tryParse("${SignInPageState.userId}") ;
  static DateTime _eventdDate = DateTime.now();
  static var now =
      TimeOfDay.fromDateTime(DateTime.parse(_eventdDate.toString()));

  String _eventTime = now.toString().substring(10, 15);


  String lastdatepick;

  bool _eventStatus = true;

  String _eventCategory;

  int counter = 0;

  List<String> categories;

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
        lastdatepick=datepick.toString().substring(0,10);
    if (datepick != null) {
      setState(() {
        _eventdDate = DateTime.parse(lastdatepick);
      });
    }
  }

  Future _pickTime() async {
    TimeOfDay timepick = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());

    if (timepick != null) {
      setState(() {
        _eventTime = timepick.toString().substring(10, 15);
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {

    
//print(_eventdDate.toString().substring(0,10));

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
            "Add new event",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Event Description',
              labelText: 'Event Description',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              setState(() {
                _eventDescription = value;
              });
            },
          ),
          SizedBox(height: 12),
          new Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 12, left: 0),
                  child: Icon(Icons.assignment, color: Colors.red, size: 30)),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 12, bottom: 15),
                child: DropdownButton(
                  value: _eventCategory,
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
                      _eventCategory = d;
                    });
                  },
                ),
              )
            ],
          ),
          CustomDateTimePicker(
           icon: Icons.date_range,
            onPressed: _pickDate,
            value: _eventdDate.toString().substring(0,10),
          ),
          CustomDateTimePicker(
            icon: Icons.access_time,
            onPressed: _pickTime,
            value: _eventTime,
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
                        value: _eventStatus,
                        onChanged: (value) {
                         // print("VALUE : $value");
                          setState(() {
                            _eventStatus = value;
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
              addevent();
             Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/EventList');
            },
          )
        ],
      ),
    );
  }

  void addevent() async {
    EventHelper eventHelper = EventHelper();
    Event event = new Event(_eventDescription, _eventCategory,
        _eventdDate.toString(), _eventTime.toString(), _eventStatus.toString(),_userId);
    try {
      if (_eventDescription != null &&
          _eventdDate != null &&
          _eventTime != null) {
        await eventHelper.addeEvent(event);
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
            _eventCategory = categories[0];
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
