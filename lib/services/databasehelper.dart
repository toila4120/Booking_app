import 'dart:io';
import 'package:booking_app/services/constant.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:booking_app/models/User.dart';
import 'package:booking_app/models/Booking.dart';

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
      CREATE TABLE User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        fullName TEXT,
        gender TEXT,
        address TEXT,
        placeOfBirth TEXT,
        dateOfBirth TEXT,
        idCard TEXT,
        email TEXT,
        phone TEXT,
        role TEXT,
        studentCode TEXT,
        teacherId TEXT
      )''');

      await db.execute('''
      CREATE TABLE Booking (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        time TEXT,
        content TEXT,
        status TEXT,
        rating REAL,
        userId INTEGER,
        FOREIGN KEY (userId) REFERENCES User(id)
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
    var res = await db.query(Constant.TABLE_USER);
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

  Future<int?> getUserId(String username) async {
    final db = await database;
    var res = await db.query("User",
        columns: ["id"], where: "username = ?", whereArgs: [username]);
    return res.first["id"] as int?;
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

  Future<List<Booking>> getTimeBookings(String date) async {
    Database db = await instance.database;
    var res = await db.query("Booking",
        where: "date = ? AND status = ?", whereArgs: [date, Constant.ACCEPT]);
    List<Booking> list =
        res.isNotEmpty ? res.map((c) => Booking.fromMap(c)).toList() : [];
    return list;
  }
}
