// lib/services/user_info_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'auth.dart'; // Import Auth dari auth_service.dart

class UserInfoService {
  final String baseUrl =
      'http://127.0.0.1:8000/api'; // Ganti dengan URL API Anda
  final String storageBaseUrl =
      'http://127.0.0.1:8000/storage/'; // URL untuk gambar

  final Auth _auth = Auth(); // Membuat instance dari Auth

  // Mengambil informasi pengguna berdasarkan token
  Future<User> fetchUserInfo() async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/profile-info'),
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
        Uri.parse('$baseUrl/user/update-profile-image'),
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
    return '$storageBaseUrl$relativePath';
  }
}
