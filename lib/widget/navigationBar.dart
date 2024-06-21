import 'package:booking_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar1 extends StatelessWidget {
  const NavBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
      activeColor: Colors.white,
      tabBackgroundColor: Colors.pink.shade200,
      padding: const EdgeInsets.all(10),
      gap: 8,
      onTabChange: (value) {
        if (value == 0) {
          Navigator.pushNamed(context, "/");
        } else if (value == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainScreen(index1: 1)));
        }
      },
      tabs: const [
        GButton(
          icon: Icons.home_outlined,
          text: 'Trang chủ',
        ),
        GButton(
          icon: Icons.calendar_month,
          text: 'Lịch hẹn',
        ),
        GButton(
          icon: Icons.add_circle_outline,
          text: 'Đặt lịch',
        ),
        GButton(
          icon: Icons.notifications_none,
          text: 'Thông báo',
        ),
        GButton(
          icon: Icons.person,
          text: 'Cá nhân',
        ),
      ],
    );
  }
}
