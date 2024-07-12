import 'package:booking_app/models/User.dart';
import 'package:booking_app/screen/MainScreen.dart';
import 'package:booking_app/services/DatabaseHelper.dart';
import 'package:booking_app/services/UserData.dart';
import 'package:booking_app/services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sqflite/sqflite.dart';

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
            // Khởi tạo UserData và gán giá trị user sau khi đăng nhập thành công
            ElevatedButton(
              onPressed: () async {
                String userNameText = userName.text;
                String passwordText = password.text;

                List<User>? users = await DatabaseHelper.instance
                    .getUser(userNameText, passwordText);

                if (users != null && users.isNotEmpty) {
                  // Đăng nhập thành công, chuyển tới màn hình chính
                  // print('hello ${users.first.id}');
                  UserData().user = users.first;
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(users.first);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        index1: 0,
                      ),
                    ),
                  );
                } else {
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
