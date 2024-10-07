import 'package:fleet_manager_driver_app/service/database.dart';
import 'package:fleet_manager_driver_app/service/global.dart';
import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isCheckedIn = false;
  String buttonText = "Check In";
  String checkinTime = '';
  String currentDate = DateFormat('dd - MMMM - yyyy').format(DateTime.now());
  String currentTime = DateFormat('hh:mm a').format(DateTime.now());

  // void _onCheckInOutPressed() {
  //   setState(() {
  //     if (!isCheckedIn) {
  //       // Check-in logic
  //       isCheckedIn = true;
  //       buttonText = "Check Out";
  //       checkinTime = "Checked-in at ${TimeOfDay.now().format(context)}";
  //       _showToast("Attendance mark started successfully");
  //     } else {
  //       // Check-out logic
  //       isCheckedIn = false;
  //       buttonText = "Check In";
  //       _showToast("Attendance mark ended successfully");
  //     }
  //   });
  // }
  void _onCheckInOutPressed() async {
  if (!isCheckedIn) {
    // Check-in logic
    await checkInAttendance(loggedInUserId); // Check in
    print("checked in for user:  $loggedInUserId");


    setState(() {
      isCheckedIn = true;
      buttonText = "Check Out";
      checkinTime = "Checked-in at ${TimeOfDay.now().format(context)}";
    });
    _showToast("Attendance marked successfully");
  } else {
    // Check-out logic
    await checkOutAttendance(loggedInUserId); // Check out
     print("Checked out for user: $loggedInUserId");


    setState(() {
      isCheckedIn = false;
      buttonText = "Check In";
    });
    _showToast("Attendance mark ended successfully");
  }
}


  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: primary,
        title: Text("ATTENDANCE",
            style: GoogleFonts.lato(
                color: secondary, fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      backgroundColor: secondary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: Colors.black, size: 18),
                const SizedBox(width: 10),
                Text(
                  currentDate,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 13.0,
              percent: 0.45, 
              center:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentTime,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  const Text("Today",
                      style: TextStyle(fontSize: 16, color: Colors.white54)),
                ],
              ),
              progressColor: primary,
            ),
            const SizedBox(height: 15),
            // Check-in time display
            Text(checkinTime,
                style: const TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            // Check In/Out Button
            ElevatedButton(
              onPressed: _onCheckInOutPressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: primary, // Button background color
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
