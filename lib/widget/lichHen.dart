import 'package:flutter/material.dart';
import 'package:booking_app/widget/text.dart'; // Đảm bảo rằng bạn có widget CustomText trong đường dẫn này

class DetailLichHen extends StatelessWidget {
  const DetailLichHen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Thêm padding để tránh overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'GV cố vấn', size: 16),
                      const SizedBox(height: 10),
                      CustomText(text: 'Địa điểm', size: 16),
                      const SizedBox(height: 10),
                      CustomText(text: 'Thời gian', size: 16),
                      const SizedBox(height: 10),
                      CustomText(text: 'Nội dung', size: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Đặng Thị Nhung', size: 16),
                      const SizedBox(height: 10),
                      CustomText(
                        text: 'Phòng 601 - Tầng 6 - A1',
                        size: 16,
                      ),
                      const SizedBox(height: 10),
                      CustomText(text: '8h30', size: 16),
                      const SizedBox(height: 10),
                      CustomText(
                        text: 'Đăng ký thực tập doanh nghiệp năm 2024',
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
