import 'dart:io';
import 'package:booking_app/models/booking.dart';
import 'package:booking_app/services/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const BookingCalendarDemoApp(),
      ),
    );
  }
}

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({super.key});

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  String buttonSelect = '';
  List<String> timeSlots = [
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30'
  ];

  List<int> buttonStates = List.generate(12, (index) => 1);

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  void fetchBookings() async {
    List<Booking> bookings =
        await DatabaseHelper.instance.getTimeBookings("2024-06-30");
    setState(() {
      for (var booking in bookings) {
        int index = timeSlots.indexOf(booking.time);
        if (index != -1) {
          buttonStates[index] = 0;
        }
      }
    });
  }

  void setButton(int index) {
    setState(() {
      for (int i = 0; i < buttonStates.length; i++) {
        if (i == index) {
          buttonStates[i] = 2;
          buttonSelect = timeSlots[i];
          // print(buttonSelect);
        } else if (buttonStates[i] != 0) {
          buttonStates[i] = 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < timeSlots.length; i += 3)
          Row(
            children: [
              for (int j = i; j < i + 3 && j < timeSlots.length; j++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonBooking(
                      timeSlots[j], buttonStates[j], () => setButton(j)),
                ),
            ],
          ),
      ],
    );
  }

  Widget ButtonBooking(String text, int trangThai, VoidCallback onPressed) {
    return OutlinedButton(
      key: Key(text),
      onPressed: trangThai == 1 ? onPressed : null,
      child: Text(text),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          trangThai == 0
              ? Colors.grey
              : trangThai == 2
                  ? Colors.blue
                  : Colors.redAccent.shade400,
        ),
      ),
    );
  }
}
