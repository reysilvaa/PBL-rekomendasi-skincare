import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import 'access_token.dart'; // Import the file that contains the storeAccessToken and getAccessToken functions

class UserInfoService {
  final String baseUrl =
      'http://127.0.0.1:8000/api'; // Replace with your actual base URL
  final String storageBaseUrl =
      'http://127.0.0.1:8000/storage/'; // Base URL for images

  // Fetch user info based on token
  Future<User> fetchUserInfo() async {
    try {
      final token = await getAccessToken();

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

  // Update user profile
  Future<User> updateUserProfile(User user) async {
    try {
      final token = await getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/user/update-profile-image'),
        headers: {
          'Authorization':
              'Bearer $token', // Use the token from SharedPreferences
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': user.username,
          'email': user.email,
          'profile_image': user.profileImage, // This will be the full URL
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

  // Helper method to get the full image URL from a relative path
  String getFullImageUrl(String relativePath) {
    return '$storageBaseUrl$relativePath';
  }
}
