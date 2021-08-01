import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ozzyschedule/AppBody.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Datebase/EventHelper/EventHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Events/Event.dart';
import 'package:ozzyschedule/Screens/Event/EventList.dart';
import 'package:ozzyschedule/Screens/Event/add_event_page.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';

class AllEvents extends StatefulWidget {
  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  DbHelper dbHelper = new DbHelper();
  EventHelper eventHelper = new EventHelper();
  List<Event> events;
  int counter = 0;

  var firstvalue;
  String lastvalue;

  bool visibiltyStatus;

int _userId = int.tryParse("${SignInPageState.userId}") ;

  static DateTime _today = DateTime.now();
  static var now = TimeOfDay.fromDateTime(DateTime.parse(_today.toString()));

  String today = now.toString().substring(10, 15);

  String aa;

  @override
  Widget build(BuildContext context) {
    // if (events != null) {
    //   events.sort((a, b) => a.eventDate.compareTo(b.eventDate));
    //   visibiltyStatus = false;
    // }

    if (events == null) {
      events = new List<Event>();
      listEvent();
      visibiltyStatus = true;
    }

    // if (aa != today) {
    //   visibiltyStatus = true;
    // }

    return AppBody(
        body: Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: taskListItems(),
      ),
      floatingActionButton: Visibility(
          visible: visibiltyStatus,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        child: AddEventPage(),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))));
                  });
            },
            child: Icon(Icons.add),
          )),
    ));
  }

  ListView taskListItems() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        aa = this.tarihler[position].eventDate;
        return Card(
            color: Color.fromRGBO(236, 240, 241, 1.0),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.event),
              ),
              title: Text(aa.toString().substring(0, 10)),
              onTap: () {
                var strTarih = tarihler[position].eventDate;

                var list =
                    events.where((r) => r.eventDate == strTarih).toList();
                openTaskDetail(list);
              },
            ));
      },

      itemCount: tarihler.length, //counter,
    );
  }

  List<Event> tarihler = new List<Event>();
  void listEvent() {
    try {
      tarihler.clear();
      var db = dbHelper.initializeDb();
      db.then((result) {
        var event = eventHelper.eventGetByUserId(_userId);
        event.then((data) {
          List<Event> eventData = new List<Event>();
          counter = data.length;
          for (var i = 0; i < counter; i++) {
            eventData.add(Event.fromObject(data[i]));
            bool kontrol = false;
            for (var item in tarihler) {
              if (item.eventDate == Event.fromObject(data[i]).eventDate) {
                kontrol = true;
              }
            }
            if (!kontrol) {
              setState(() {
                tarihler.add(Event.fromObject(data[i]));
              });
            }
          }
          setState(() {
            events = eventData;
            counter = counter;
            print("Count of Listed Event : $counter");
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void openTaskDetail(List<Event> event) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (contex) => EventList(event)));
  }
}
