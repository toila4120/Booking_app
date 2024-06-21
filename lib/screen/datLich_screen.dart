import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatLich extends StatefulWidget {
  const DatLich({super.key});

  @override
  State<DatLich> createState() => _DatLichState();
}

class _DatLichState extends State<DatLich> {
  @override
  Widget build(BuildContext context) {
    String _datetime = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
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
                      onPressed: () {},
                      icon: Icon(Icons.calendar_month),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
