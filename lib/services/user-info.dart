import 'dart:convert';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:deteksi_jerawat/services/pick_image_and_upload.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'auth.dart';
import 'pick_image_and_upload.dart'; // Import service image upload

class UserInfoService {
  final Auth _auth = Auth(); // Membuat instance dari Auth
  final ImageUploadService _imageUploadService =
      ImageUploadService(); // Membuat instance dari ImageUploadService

  // Mengambil informasi pengguna berdasarkan token
  Future<User> fetchUserInfo() async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/user/profile-info'),
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

  // Memperbarui profil pengguna (tanpa profile image)
  Future<User> updateUserProfile(User user) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse('${Config.baseUrl}/user/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': user.username,
          'first_name': user.firstName,
          'last_name': user.lastName,
          'birth_date': user.birthDate,
          'phone_number': user.phoneNumber,
          'email': user.email,
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

  // Memperbarui gambar profil pengguna
  Future<String> updateProfileImage() async {
    try {
      // Panggil ImageUploadService untuk memilih dan mengunggah gambar
      final profileImagePath = await _imageUploadService.pickImageAndUpload();
      return profileImagePath;
    } catch (e) {
      throw Exception('Failed to update profile image: $e');
    }
  }

  // Metode untuk mendapatkan URL lengkap gambar dari path relatif
  String getFullImageUrl(String relativePath) {
    return relativePath;
  }
}
