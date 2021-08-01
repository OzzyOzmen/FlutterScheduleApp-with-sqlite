import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/EventHelper/EventHelper.dart';
import 'package:ozzyschedule/Models/Schedule/Events/Event.dart';
import 'package:ozzyschedule/widgets/custom_modal_delete_button.dart';

class DeleteEvent extends StatefulWidget {
  Event event;
  DeleteEvent(this.event);

  @override
  _DeleteEventState createState() => _DeleteEventState(event);
}

class _DeleteEventState extends State<DeleteEvent> {
  Event event;
  _DeleteEventState(this.event);

  TextEditingController eventId;
  TextEditingController eventDescription;

  @override
  void initState() {
    super.initState();

    eventId = new TextEditingController(text: '${event.eventId}');
    eventDescription = new TextEditingController(text: '${event.eventDescription}');
    
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            "Delete This Event",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          
          Text(
            "Are you sure you want to delete this event ?",
            
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            child: CustomModalDeleteButton(
              onClose: () {
                Navigator.of(context).pop();
              },
              onDelete: () {
                deleteEvent();
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, '/EventList');
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

   void deleteEvent() async {
     int id = int.parse("${eventId.text}");
    EventHelper eventHelper = EventHelper();
    await eventHelper.deleteEvent(id);
    
  }
}
