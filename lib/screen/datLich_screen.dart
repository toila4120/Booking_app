import 'package:booking_app/models/booking.dart';
import 'package:booking_app/services/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatLich extends StatefulWidget {
  const DatLich({super.key});

  @override
  State<DatLich> createState() => _DatLichState();
}

class _DatLichState extends State<DatLich> {
  String? _datetime = DateFormat("dd/MM/yyyy").format(DateTime.now());

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
    fetchBookings(DateTime.now());
  }

  void fetchBookings(DateTime date) async {
    String fmDateTime = DateFormat("yyyy-MM-dd").format(date);
    List<Booking> bookings =
        await DatabaseHelper.instance.getTimeBookings(fmDateTime);
    setState(() {
      // Reset trạng thái của các nút về trạng thái mặc định
      buttonStates = List.generate(12, (index) => 1);
      // Cập nhật trạng thái mới từ cơ sở dữ liệu
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
        } else if (buttonStates[i] != 0) {
          buttonStates[i] = 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Đặt là true để giao diện tự động điều chỉnh khi bàn phím xuất hiện
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
                  maxLines: null,
                  minLines: 1,
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
        backgroundColor: WidgetStateProperty.all<Color>(
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
