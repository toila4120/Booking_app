// import 'package:booking_app/models/booking.dart';
import 'package:booking_app/models/Booking.dart';
import 'package:booking_app/screen/login_screen.dart';
import 'package:booking_app/services/DatabaseHelper.dart';
import 'package:booking_app/services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database db = await DatabaseHelper.instance.database;

  // // Thêm một người dùng vào bảng User
  // User newUser1 = User(
  //     username: "tanh1234",
  //     password: "123",
  //     fullName: "Nguyễn Tuấn Đạt",
  //     gender: Constant.GENDER_MALE,
  //     address: "123 Main St",
  //     placeOfBirth: "City A",
  //     dateOfBirth: "2000-01-01",
  //     idCard: "ID123456",
  //     email: "user1@example.com",
  //     phone: "1234567890",
  //     role: Constant.ROLE_TEACHER,
  //     studentCode: "S12345",
  //     teacherId: "1");
  // await DatabaseHelper.instance.insertUser(newUser1);

  // User newUser = User(
  //     username: "tanh123",
  //     password: "123",
  //     fullName: "Nguyễn Tiến Anh",
  //     gender: Constant.GENDER_MALE,
  //     address: "123 Main St",
  //     placeOfBirth: "City A",
  //     dateOfBirth: "2000-01-01",
  //     idCard: "ID123456",
  //     email: "user1@example.com",
  //     phone: "1234567890",
  //     role: Constant.ROLE_STUDENT,
  //     studentCode: "S12345",
  //     teacherId: "1");
  // await DatabaseHelper.instance.insertUser(newUser);

  // Thêm một Booking vào bảng Booking
  // Booking newBooking = Booking(
  //     date: "2024-07-02",
  //     time: "09:00",
  //     content: "Meeting12",
  //     status: "Confirmed",
  //     rating: 0,
  //     userId: 2);
  // await DatabaseHelper.instance.insertBooking(newBooking);

  // // Truy vấn tất cả các người dùng
  // List<User> users = await DatabaseHelper.instance.getUsers();
  // users != null ? print("Users: ${users.first.username}") : print("null");

  // // // Truy vấn tất cả các Booking
  // List<Booking> bookings = await DatabaseHelper.instance.getBookings();
  // print("Bookings: $bookings");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
