import 'package:booking_app/screen/main_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                  labelText: "Mã sinh viên",
                  hintText: "Nhập mã sinh viên",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                keyboardType: TextInputType.number,
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
                  hintText: "Nhập mã mật khẩu",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your student code';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 50),
            // Text('Sai tên đăng nhập hoặc mật khẩu',style: TextStyle(color: Colors.red),)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreen(
                              index1: 0,
                            )));
              },
              child: const Text('Đăng nhập'),
            )
          ],
        ),
      ),
    );
  }
}
