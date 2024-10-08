import 'dart:async';
import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isCheckedIn = false;
  String buttonText = "Check In";
  String checkinTime = '';
  String currentDate = DateFormat('dd - MMMM - yyyy').format(DateTime.now());
  String currentTime = DateFormat('hh:mm a').format(DateTime.now());
  DateTime? checkInDateTime; // Track when the user checked in
  Timer? _timer;
  double percentage = 0.0; // Progress of the 12-hour period

  @override
  void initState() {
    super.initState();
    _loadCheckInStatus();
  }

  Future<void> _loadCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedIsCheckedIn = prefs.getBool('isCheckedIn');
    String? storedCheckInTime = prefs.getString('checkInDateTime');

    if (storedIsCheckedIn != null && storedCheckInTime != null) {
      setState(() {
        isCheckedIn = storedIsCheckedIn;
        checkInDateTime = DateTime.parse(storedCheckInTime);
        buttonText = isCheckedIn ? "Check Out" : "Check In";
        checkinTime = "Checked-in at ${DateFormat('hh:mm a').format(checkInDateTime!)}";
        if (isCheckedIn) {
          startTimer();
        }
      });
    }
  }

  Future<void> _saveCheckInStatus(bool isCheckedIn, DateTime? checkInDateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCheckedIn', isCheckedIn);
    if (checkInDateTime != null) {
      await prefs.setString('checkInDateTime', checkInDateTime.toIso8601String());
    }
  }

  Future<void> _clearCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isCheckedIn');
    await prefs.remove('checkInDateTime');
  }

  void _onCheckInOutPressed() async {
    if (!isCheckedIn) {
      // Check-in logic
      setState(() {
        isCheckedIn = true;
        buttonText = "Check Out";
        checkInDateTime = DateTime.now();
        checkinTime = "Checked-in at ${DateFormat('hh:mm a').format(checkInDateTime!)}";
        startTimer();
      });

      // Save the check-in status and time
      await _saveCheckInStatus(isCheckedIn, checkInDateTime);

      _showToast("Attendance marked successfully");
    } else {
      // Check-out logic
      setState(() {
        isCheckedIn = false;
        buttonText = "Check In";
        _timer?.cancel(); // Stop the timer when checked out
        percentage = 0.0; // Reset the progress
      });

      // Clear the check-in status
      await _clearCheckInStatus();

      _showToast("Attendance mark ended successfully");
    }
  }

  void startTimer() {
    const oneMinute = Duration(minutes: 1);
    _timer = Timer.periodic(oneMinute, (Timer timer) {
      setState(() {
        calculateProgress();
      });
    });
  }

  void calculateProgress() {
    if (checkInDateTime != null) {
      final now = DateTime.now();
      final elapsed = now.difference(checkInDateTime!).inMinutes; // Elapsed minutes since check-in
      final totalMinutes = 12 * 60; // Total minutes in 12 hours

      setState(() {
        percentage = elapsed / totalMinutes;
        if (percentage >= 1.0) {
          percentage = 1.0; // Cap at 100% once 12 hours have passed
          _timer?.cancel(); // Stop the timer when the period is over
        }
      });
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title:  Text("Attendance", style:  GoogleFonts.lato(
                color: secondary, fontSize: 20, fontWeight: FontWeight.w700),),
        backgroundColor: primary,
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
              percent: percentage, // Dynamic percentage
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentTime,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
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
            Text(
              checkinTime,
              style: const TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Check In/Out Button
            ElevatedButton(
              onPressed: _onCheckInOutPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: primary, // Button background color
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }
}
