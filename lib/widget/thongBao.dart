import 'package:booking_app/screen/MainScreen.dart';
import 'package:flutter/material.dart';

class ThongBao extends StatelessWidget {
  const ThongBao({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 190,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [],
                border: Border.all(
                  color: Colors.transparent,
                ),
                color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Card(
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lịch hẹn trong ngày',
                      style: TextStyle(color: Colors.amber.shade200),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bạn có cuộc hẹn sắp tới',
                      style: TextStyle(color: Colors.green.shade300),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Địa điểm: Phòng 601 - Tầng 6 - A1',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thời gian: 8h30',
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainScreen(index1: 1)));
                          },
                          child: Text(
                            'Xem chi tiết',
                            style: TextStyle(color: Colors.blue.shade300),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
