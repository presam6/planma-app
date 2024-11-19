import 'package:flutter/material.dart';
import 'package:planma_app/event/edit_event.dart';
import 'package:planma_app/event/widget/event_detail_row.dart';

class ViewEvent extends StatelessWidget {
  final String eventName;
  final String timePeriod;
  final String description;
  final String location;
  final String date;
  final String type;

  const ViewEvent({
    Key? key,
    required this.eventName,
    required this.timePeriod,
    required this.description,
    required this.location,
    required this.date,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditEvent()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.blue),
            onPressed: () {
              // Add delete functionality
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          'Event',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventDetailRow(
                    title: 'Title',
                    value: eventName,
                  ),
                  EventDetailRow(
                    title: 'Description',
                    value: description,
                  ),
                  EventDetailRow(
                    title: 'Location',
                    value: location,
                  ),
                  EventDetailRow(
                    title: 'Date',
                    value: date,
                  ),
                  EventDetailRow(
                    title: 'Time',
                    value: timePeriod,
                  ),
                  EventDetailRow(
                    title: 'Type',
                    value: type,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
