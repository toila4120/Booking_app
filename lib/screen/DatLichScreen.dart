import 'package:booking_app/models/Booking.dart';
import 'package:booking_app/models/User.dart';
import 'package:booking_app/services/DatabaseHelper.dart';
import 'package:booking_app/services/UserData.dart';
import 'package:booking_app/services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatLich extends StatefulWidget {
  const DatLich({super.key});

  @override
  State<DatLich> createState() => _DatLichState();
}

class _DatLichState extends State<DatLich> {
  // User? user;
  String? _datetime = DateFormat("dd/MM/yyyy").format(DateTime.now());
  DateTime? _dateTimeNow = DateTime.now();
  int? _id;

  final _LyDoController = TextEditingController();
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
    // user = UserData().user;
    fetchBookings(DateTime.now());
  }

  void fetchBookings(DateTime date) async {
    String fmDateTime = DateFormat("yyyy-MM-dd").format(date);
    List<Booking> bookings =
        await DatabaseHelper.instance.getTimeBookings(fmDateTime);
    setState(() {
      buttonStates = List.generate(12, (index) => 1);
      for (var booking in bookings) {
        int index = timeSlots.indexOf(booking.time);
        if (index != -1) {
          buttonStates[index] = 0;
        }
      }
    });
  }

  Future<void> getID(User user) async {
    final id = await DatabaseHelper.instance.getUserId(user.username);
    setState(() {
      _id = id;
    });
  }

  void setButton(int index) {
    setState(() {
      for (int i = 0; i < buttonStates.length; i++) {
        if (i == index) {
          buttonStates[i] = 2;
          buttonSelect = timeSlots[i];
        } else if (buttonStates[i] != 0) {
          buttonStates[i] = 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 245, 243, 243),
            Color.fromARGB(255, 246, 226, 226)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Align(
                  child: Text(
                    "Cố vấn học tập",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Thời gian: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 24,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Đặng Thị Nhung",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: 0),
                Row(
                  children: [
                    Text(
                      "Ngày tháng: ",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "$_datetime",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 1),
                    IconButton(
                      onPressed: () async {
                        DateTime _dateTimeNow = DateTime.now();
                        DateTime? _datetime1 = await showDatePicker(
                          context: context,
                          initialDate: _dateTimeNow,
                          firstDate: _dateTimeNow.subtract(Duration(days: 1)),
                          lastDate: _dateTimeNow.add(Duration(days: 7)),
                        );
                        if (_datetime1 != null) {
                          setState(() {
                            _dateTimeNow = _datetime1;
                            _datetime =
                                DateFormat("dd/MM/yyyy").format(_datetime1);
                          });
                          fetchBookings(_datetime1);
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                SizedBox(height: 0),
                Text(
                  "Chọn thời gian",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Column(
                  children: [
                    for (int i = 0; i < timeSlots.length; i += 3)
                      Row(
                        children: [
                          for (int j = i;
                              j < i + 3 && j < timeSlots.length;
                              j++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ButtonBooking(timeSlots[j],
                                  buttonStates[j], () => setButton(j)),
                            ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Lý do hẹn gặp",
                    labelText: "Lý do",
                  ),
                  controller: _LyDoController,
                  maxLines: null,
                  minLines: 1,
                ),
                SizedBox(height: 16),
                Center(
                  child: OutlinedButton(
                    onPressed: () async {
                      if (_dateTimeNow != null) {
                        String fmDateTime =
                            DateFormat("yyyy-MM-dd").format(_dateTimeNow!);
                        getID(user!);
                        print(user.username);
                        Booking newBooking = Booking(
                          date: fmDateTime.toString(),
                          time: buttonSelect.toString(),
                          content: _LyDoController.text,
                          status: "Confirmed",
                          rating: 0,
                          userId: _id!,
                        );
                        await DatabaseHelper.instance.insertBooking(newBooking);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Vui lòng chọn ngày tháng hợp lệ."),
                          ),
                        );
                      }
                    },
                    child: Text("Đặt lịch"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ButtonBooking(String text, int trangThai, VoidCallback onPressed) {
    return OutlinedButton(
      key: Key(text),
      onPressed: trangThai == 1 ? onPressed : null,
      child: Text(text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          trangThai == 0
              ? Colors.grey
              : trangThai == 2
                  ? Colors.blue
                  : Colors.white,
        ),
      ),
    );
  }
}
