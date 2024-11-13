// lib/services/user_info_service.dart
import 'dart:convert';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'auth.dart'; // Import Auth dari auth_service.dart

class UserInfoService {
  final Auth _auth = Auth(); // Membuat instance dari Auth

  // Mengambil informasi pengguna berdasarkan token
  Future<User> fetchUserInfo() async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(
            '${Config.baseUrl}/user/profile-info'), // Menggunakan baseUrl dari Auth
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['user'] != null) {
          return User.fromJson(data['user']);
        } else {
          throw Exception('User data not found in the response.');
        }
      } else {
        throw Exception('Failed to fetch user info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Memperbarui profil pengguna
  Future<User> updateUserProfile(User user) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse(
            '${Config.baseUrl}/user/update-profile-image'), // Menggunakan baseUrl dari Auth
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': user.username,
          'email': user.email,
          'profile_image': user.profileImage,
          'gender': user.gender,
          'age': user.age,
          'level': user.level,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return User.fromJson(data['user']);
      } else {
        throw Exception(
            'Failed to update user profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Metode untuk mendapatkan URL lengkap gambar dari path relatif
  String getFullImageUrl(String relativePath) {
    // Menambahkan base URL gambar ke path gambar relatif
    return '${Config.baseUrl.replaceFirst('/api', '')}/storage/$relativePath';
  }
}
