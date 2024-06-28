import 'package:booking_app/models/user.dart';
import 'package:booking_app/screen/datLich_screen.dart';
import 'package:booking_app/screen/lichHen_screen.dart';
import 'package:booking_app/screen/trang_chu_screen.dart';
import 'package:booking_app/services/userData.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.index1});
  final int index1;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;
  User? user = UserData().user!;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.index1;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const TrangChu();
    if (_selectedPageIndex == 0) {
      activePage = const TrangChu();
    }
    if (_selectedPageIndex == 1) {
      activePage = const LichHen();
    }
    if (_selectedPageIndex == 2) {
      activePage = const DatLich();
    }
    return Scaffold(
      floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton.extended(
            label: const Icon(Icons.add, size: 30, color: Colors.black),
            onPressed: () {
              _selectPage(2);
            },
            shape: const CircleBorder(),
            // child: const Icon(Icons.add),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Hi, ${user?.fullName}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: activePage,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          _selectPage(value);
        },
        indicatorColor: _selectedPageIndex == 2
            ? Colors.transparent
            : const Color.fromARGB(255, 246, 228, 228),
        selectedIndex: _selectedPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Lịch hẹn',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.add,
                color: Colors.transparent,
              ),
              label: ''),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            label: 'Thông báo',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
