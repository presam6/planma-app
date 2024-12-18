import 'package:flutter/material.dart';
import 'package:planma_app/activities/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:planma_app/Providers/user_provider.dart';
import 'package:planma_app/Front%20&%20back%20end%20connections/activity_service.dart';
import 'package:google_fonts/google_fonts.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivityScreen> {
  final _activityNameController = TextEditingController();
  final _activityDescriptionController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  DateTime? _scheduledDate;

  void _selectDate(BuildContext context, DateTime? initialDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _scheduledDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  String to24HourFormat(String time) {
    String finalStrTime = "";
    List<String> timeSplit = time.split(":");
    timeSplit[1] = timeSplit[1].split(" ").first;
    if (time.split(" ")[1] == "PM") {
      if (time.split(":").first == "12") {
        // dont adjust by 12 hours if 12 PM
        finalStrTime = "${timeSplit[0]}:${timeSplit[1]}";
      } else {
        finalStrTime =
            "${(int.parse(timeSplit[0]) + 12).toString()}:${timeSplit[1]}";
      }
    } else if (time.split(" ")[1] == "AM" && time.split(":").first == "12") {
      // if 12 AM, adjust by - 12
      finalStrTime =
          "${(int.parse(timeSplit[0]) - 12).toString()}:${timeSplit[1]}";
    } else {
      // if <12 PM just return hh:mm
      finalStrTime = "${timeSplit[0]}:${timeSplit[1]}";
    }
    return finalStrTime;
  }

  Future<void> _createActivity() async {
    if (_activityNameController.text.isEmpty ||
        _activityDescriptionController.text.isEmpty ||
        _scheduledDate == null ||
        _startTimeController.text.isEmpty ||
        _endTimeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }
    final eventService = ActivityCreate();
    // Collect data from UI inputs
    final String activityName = _activityNameController.text;
    final String activityDesc = _activityDescriptionController.text;
    final String activityDate =
        _scheduledDate!.toIso8601String().split("T").first;
    final String startTime = _startTimeController.text;
    final String endTime = _endTimeController.text;

    // Call the service

    final result = await eventService.activityCT(
        activityname: activityName,
        activitydesc: activityDesc,
        scheduledate: activityDate,
        starttime: to24HourFormat(startTime),
        endtime: to24HourFormat(endTime),
        status: "0",
        //status: (context.read<UserProvider>().userName!), // need to change for now para walay error
        studentID:
            Jwt.parseJwt(context.read<UserProvider>().accessToken!)['user_id']);

    // Handle response
    if (result != null && result.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['error'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event created successfully!')),
      );
      Navigator.of(context).pop(); // Navigate back on success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Activities',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF173F70)),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Color(0xFFFFFFFF),
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomWidgets.buildTitle(
                    'Activity Name',
                  ),
                  const SizedBox(height: 12),
                  CustomWidgets.buildTextField(
                      _activityNameController, 'Activity Name'),
                  SizedBox(height: 12),
                  CustomWidgets.buildTitle(
                    'Description',
                  ),
                  const SizedBox(height: 12),
                  CustomWidgets.buildTextField(
                      _activityDescriptionController, 'Description'),
                  SizedBox(height: 12),
                  CustomWidgets.buildTitle(
                    'Scheduled Date',
                  ),
                  const SizedBox(height: 12),
                  CustomWidgets.buildDateTile(
                      '', _scheduledDate, context, true, _selectDate),
                  SizedBox(height: 12),
                  CustomWidgets.buildTitle(
                    'Start and End Time',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomWidgets.buildTimeField(
                          'Start Time',
                          _startTimeController,
                          context,
                          (context) =>
                              _selectTime(context, _startTimeController),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomWidgets.buildTimeField(
                          'End Time',
                          _endTimeController,
                          context,
                          (context) => _selectTime(context, _endTimeController),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _createActivity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF173F70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                ),
                child: Text(
                  'Create Activity',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
