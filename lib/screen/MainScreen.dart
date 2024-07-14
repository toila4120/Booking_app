// import 'package:booking_app/models/User.dart';
import 'package:booking_app/screen/DatLichScreen.dart';
// import 'package:booking_app/screen/DatLichTest.dart';
import 'package:booking_app/screen/LichHenScreen.dart';
import 'package:booking_app/screen/LoginScreen.dart';
import 'package:booking_app/screen/TrangChuScreen.dart';
import 'package:booking_app/screen/detailPersional.dart';
// import 'package:booking_app/services/UserData.dart';
import 'package:booking_app/services/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.index1});
  final int index1;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;
  // User? user;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.index1;
    // user = UserData().user;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
    if (_selectedPageIndex == 4) {
      activePage = const Detailpersional();
    }
    if (_selectedPageIndex == 5) {
      activePage = Login();
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
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).clearUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Hi, ${user?.fullName ?? ''}',
          style: const TextStyle(fontWeight: FontWeight.w600),
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
