import 'dart:io';
import 'package:booking_app/services/constant.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:booking_app/models/user.dart';
import 'package:booking_app/models/booking.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE ${Constant.TABLE_USER} (
        id INTEGER PRIMARY KEY,
        ${Constant.USERNAME} TEXT,
        ${Constant.PASSWORD} TEXT,
        ${Constant.FULL_NAME} TEXT,
        ${Constant.GENDER} TEXT,
        ${Constant.ADDRESS} TEXT,
        ${Constant.PLACE_OF_BIRTH} TEXT,
        ${Constant.DATE_OF_BIRTH} TEXT,
        ${Constant.ID_CARD} TEXT,
        ${Constant.EMAIL} TEXT,
        ${Constant.PHONE} TEXT,
        ${Constant.ROLE} TEXT,
        ${Constant.STUDENT_CODE} TEXT,
        ${Constant.TEACHER_ID} TEXT
      )''');

      await db.execute('''
      CREATE TABLE ${Constant.TABLE_BOOKING} (
        id INTEGER PRIMARY KEY,
        ${Constant.DATE} TEXT,
        ${Constant.TIME} TEXT,
        ${Constant.CONTENT} TEXT,
        ${Constant.STATUS} TEXT,
        ${Constant.RATING} REAL,
        ${Constant.USER_ID} INTEGER,
        FOREIGN KEY (${Constant.USER_ID}) REFERENCES User(id)
      )''');
    });
  }

  // CRUD methods for User
  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert("User", user.toMap());
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var res = await db.query("${Constant.TABLE_USER}");
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<User>?> getUser(String username, String password) async {
    final db = await database;
    var res = await db.query("User",
        where: "${Constant.USERNAME} = ? AND ${Constant.PASSWORD} = ?",
        whereArgs: [username, password]);
    if (res.isNotEmpty) {
      return res.map((c) => User.fromMap(c)).toList();
    }
    return null;
  }

  // CRUD methods for Booking
  Future<int> insertBooking(Booking booking) async {
    Database db = await instance.database;
    return await db.insert("Booking", booking.toMap());
  }

  Future<List<Booking>> getBookings() async {
    Database db = await instance.database;
    var res = await db.query("Booking");
    List<Booking> list =
        res.isNotEmpty ? res.map((c) => Booking.fromMap(c)).toList() : [];
    return list;
  }
}
