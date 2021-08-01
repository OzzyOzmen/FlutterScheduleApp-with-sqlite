import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Datebase/EventHelper/EventHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Events/Event.dart';
import 'package:ozzyschedule/Screens/Event/DeleteEvent.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';
import 'package:ozzyschedule/widgets/custom_icon_decoration.dart';

class EventList extends StatefulWidget {
  List<Event> event;
  EventList(this.event);
  @override
  _EventListState createState() => _EventListState(event);
}

class _EventListState extends State<EventList> {
    List<Event> event;
  _EventListState(this.event);
  
  DbHelper dbHelper = new DbHelper();
  EventHelper eventHepler = new EventHelper();
  List<Event> events;
  int counter = 0;

  bool _eventStatus;

  static DateTime _todaydDate = DateTime.now();
  static var now =
      TimeOfDay.fromDateTime(DateTime.parse(_todaydDate.toString()));

  // String _currentTime = now.toString().substring(10, 15);
int _userId = int.tryParse("${SignInPageState.userId}") ;
   
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
String _crntDate;
    for (var item in event) {
     _crntDate =item.eventDate.toString().substring(0,10);
    }

    if (events != null) {
      events.sort((a, b) => a.eventTime.compareTo(b.eventTime));
    }

    if (events == null) {
      events = new List<Event>();
      listEvent();
    }

    return  Scaffold(
      appBar: AppBar(title: Text("Event Date: $_crntDate"),),
      body: ListView.builder(
        itemCount: events.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, position) {
          
          if (this.events[position].eventStatus == "true") {
            _eventStatus = true;
          }
          if (this.events[position].eventStatus == "false") {
            _eventStatus = false;
          }

          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Row(
              children: <Widget>[
                _lineStyle(
                    context, iconSize, position, events.length, _eventStatus),
                _displayTime(this.events[position].eventTime),
                _displayContent(events[position]),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      deleteEvent(this.events[position]);
                    }),
              ],
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //         barrierDismissible: false,
      //         context: context,
      //         builder: (BuildContext context) {
      //           return Dialog(
      //               child: AddEvent(),
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.all(Radius.circular(12))));
      //         });
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget _displayContent(Event event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.eventDescription),
              SizedBox(
                height: 12,
              ),
              Text(event.evetCategory),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayTime(String time) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(time),
        ));
  }

  Widget _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
        decoration: CustomIconDecoration(
            iconSize: iconSize,
            lineWidth: 1,
            firstData: index == 0 ?? true,
            lastData: index == listLength - 1 ?? true),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
          child: Icon(
              isFinish
                  ? Icons.fiber_manual_record
                  : Icons.radio_button_unchecked,
              size: iconSize,
              color: Theme.of(context).accentColor),
        ));
  }

  void listEvent() {
    try {
       setState(() {
            events = event;
            counter = counter;
            print("Count of Listed event : $counter");
          });
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteEvent(Event event) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: DeleteEvent(event),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))));
        });
  }
}
