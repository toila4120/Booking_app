import 'package:booking_app/screen/datLich_screen.dart';
import 'package:booking_app/widget/thongBao.dart';
import 'package:flutter/material.dart';

class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 245, 243, 243),
            Color.fromARGB(255, 246, 226, 226)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const ThongBao(),
                const SizedBox(height: 40),
                const Row(
                  children: [
                    SizedBox(width: 16),
                    Text(
                      'Cố vấn học tập',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đặng Thị Nhung',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const Text(
                              'Khoa Công Nghệ Thông Tin',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                backgroundColor:
                                    Color.fromARGB(255, 213, 235, 236),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('4'),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DatLich()));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.send,
                                        color: Color.fromARGB(255, 201, 44, 91),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Đặt lịch',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
