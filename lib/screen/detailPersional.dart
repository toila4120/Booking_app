import 'package:booking_app/models/user.dart';
import 'package:booking_app/services/userData.dart';
import 'package:flutter/material.dart';

class Detailpersional extends StatelessWidget {
  Detailpersional({super.key});

  @override
  User? user = UserData().user!;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${user?.fullName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${user?.idCard}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Lớp\n2021DHCNTT01',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Khoa\nKhoa CNTT',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildInfoSection('Thông tin sinh viên', [
                buildInfoRow('Ngày sinh', '${user?.dateOfBirth}'),
                buildInfoRow('Giới tính', '${user?.gender}'),
                buildInfoRow('Nơi sinh', '${user?.address}'),
                buildInfoRow('Số CMND/CCCD', '${user?.idCard}'),
              ]),
              SizedBox(height: 20),
              buildInfoSection('Thông tin liên hệ', [
                buildInfoRow('Số điện thoại', '${user?.phone}'),
                buildInfoRow('Email', '${user?.email}'),
                buildInfoRow('Địa chỉ', '${user?.address}'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoSection(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: children,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
