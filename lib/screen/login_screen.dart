import 'package:booking_app/models/user.dart';
import 'package:booking_app/screen/main_screen.dart';
import 'package:booking_app/services/databasehelper.dart';
import 'package:booking_app/services/userData.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final userName = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'ĐẠI HỌC CÔNG NGHIỆP HÀ NỘI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'HANOI UNIVERSITY OF INDUSTRY',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Tài khoản sinh viên",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: userName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your student code';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Mật khẩu",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                keyboardType: TextInputType.text,
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                // Lấy giá trị từ TextEditingController
                String userNameText = userName.text;
                String passwordText = password.text;

                // Lấy dữ liệu người dùng từ cơ sở dữ liệu
                List<User>? users = await DatabaseHelper.instance
                    .getUser(userNameText, passwordText);

                // Kiểm tra thông tin đăng nhập
                if (users != null && users.isNotEmpty) {
                  // Đăng nhập thành công, chuyển tới màn hình chính
                  print('hello ${users.first.id}');
                  UserData().user = users.first;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        index1: 0,
                      ),
                    ),
                  );
                } else {
                  // Đăng nhập thất bại, hiển thị thông báo lỗi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Sai tên đăng nhập hoặc mật khẩu')),
                  );
                }
              },
              child: const Text('Đăng nhập'),
            )
          ],
        ),
      ),
    );
  }
}
