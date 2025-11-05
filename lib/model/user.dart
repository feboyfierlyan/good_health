import 'dart:convert';
import 'package:http/http.dart';
import 'package:good_health/model/pasien.dart'; // Pastikan ini ada
import 'package:http/http.dart' as http;
import 'package:good_health/util/config.dart';

class User {
  // JADIKAN OPSIONAL dengan tanda tanya (?)
  final String? idUser, username, password;
  final Pasien? idPasien;

  // HAPUS 'required' dari idUser dan idPasien
  User({
    this.idUser,
    required this.username,
    required this.password,
    this.idPasien,
  });

  // Factory 'fromJson' sudah benar, biarkan saja
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'].toString(),
      username: json['username'],
      password: json['password'],
      idPasien: json['id_pasien'] != null
          ? Pasien.fromJson(json['id_pasien'])
          : null,
    );
  }
}

// Fungsi login sudah benar, biarkan saja
Future<Response?> login(User user) async {
  try {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/login.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'username': user.username, 'password': user.password}),
    );

    print(response.body.toString());

    return response;
  } catch (e) {
    print("Error : ${e.toString()}");
    return null;
  }
}
