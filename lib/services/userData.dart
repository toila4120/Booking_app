import 'package:booking_app/models/user.dart';

class UserData {
  static final UserData _data = UserData._internal();

  factory UserData() {
    return _data;
  }

  UserData._internal();

  User? user;
}
