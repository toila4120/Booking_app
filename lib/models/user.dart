import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String userToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  static int _nextId = 1; // Biến tĩnh lưu giá trị ID hiện tại

  int? id;
  String username;
  String password;
  String fullName;
  String gender;
  String address;
  String placeOfBirth;
  String dateOfBirth;
  String idCard;
  String email;
  String phone;
  String role;
  String studentCode;
  String teacherId;

  User({
    required this.username,
    required this.password,
    required this.fullName,
    required this.gender,
    required this.address,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.idCard,
    required this.email,
    required this.phone,
    required this.role,
    required this.studentCode,
    required this.teacherId,
  }); // Tự động gán và tăng giá trị ID

  // Nếu cần, bạn có thể thêm phương thức reset cho _nextId
  static void resetId() {
    _nextId = 1;
  }

  factory User.fromMap(Map<String, dynamic> json) => new User(
        username: json["username"],
        password: json["password"],
        fullName: json["fullName"],
        gender: json["gender"],
        address: json["address"],
        placeOfBirth: json["placeOfBirth"],
        dateOfBirth: json["dateOfBirth"],
        idCard: json["idCard"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        studentCode: json["studentCode"],
        teacherId: json["teacherId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "fullName": fullName,
        "gender": gender,
        "address": address,
        "placeOfBirth": placeOfBirth,
        "dateOfBirth": dateOfBirth,
        "idCard": idCard,
        "email": email,
        "phone": phone,
        "role": role,
        "studentCode": studentCode,
        "teacherId": teacherId,
      };
}
