import 'package:booking_app/models/Booking.dart';
import 'package:booking_app/services/databasehelper.dart';
import 'package:booking_app/widget/LichHen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class LichHen extends StatefulWidget {
  const LichHen({super.key});

  @override
  State<LichHen> createState() => _LichHenState();
}

class _LichHenState extends State<LichHen> {
  DateTime today = DateTime.now();
  String fmDateTime = "";
  Future<List<Booking>>? bookings;

  @override
  void initState() {
    fmDateTime = DateFormat("yyyy-MM-dd").format(today);
    bookings = DatabaseHelper.instance.getTimeBookings(fmDateTime);
    super.initState();
  }

  void _onDaySelected(DateTime day, DateTime focus) {
    setState(() {
      today = day;
      fmDateTime = DateFormat("yyyy-MM-dd").format(today);
      bookings = DatabaseHelper.instance.getTimeBookings(fmDateTime);
      // print("hello ${bookings.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 245, 243, 243),
            Color.fromARGB(255, 246, 226, 226)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lịch hẹn của bạn',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: TableCalendar(
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  locale: "en_US",
                  onDaySelected: _onDaySelected,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime(today.year, today.month, 1),
                  lastDay: DateTime(today.year, today.month + 1, 1)
                      .subtract(const Duration(days: 1)),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Chi tiết theo ngày',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ngày ${DateFormat('dd/MM/yyyy').format(today)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      FutureBuilder<List<Booking>>(
                          future: bookings,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('No bookings available'));
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final booking = snapshot.data![index];
                                  return DetailLichHen(booking: booking);
                                },
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
