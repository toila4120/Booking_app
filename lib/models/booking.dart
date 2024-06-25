import 'dart:convert';

Booking bookingFromJson(String str) {
  final jsonData = json.decode(str);
  return Booking.fromMap(jsonData);
}

String bookingToJson(Booking data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Booking {
  static int _nextId = 1; // Biến tĩnh lưu giá trị ID hiện tại

  int id;
  String date;
  String time;
  String content;
  String status;
  double rating;
  int userId;

  Booking({
    required this.date,
    required this.time,
    required this.content,
    required this.status,
    required this.rating,
    required this.userId,
  }) : id = _nextId++; // Tự động gán và tăng giá trị ID

  factory Booking.fromMap(Map<String, dynamic> json) => new Booking(
        date: json["date"],
        time: json["time"],
        content: json["content"],
        status: json["status"],
        rating: json["rating"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "time": time,
        "content": content,
        "status": status,
        "rating": rating,
        "userId": userId,
      };
}
