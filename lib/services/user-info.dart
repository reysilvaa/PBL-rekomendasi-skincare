import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class UserInfoService {
  final String baseUrl = 'http://127.0.0.1:8000/api'; // Replace with your actual base URL

  // Fetch user info based on token
  Future<User> fetchUserInfo() async {
    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token'); // Access token is now stored as 'access_token'

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
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token'); // Access token is now stored as 'access_token'

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/user/update'),
        headers: {
          'Authorization': 'Bearer $token', // Use the token from SharedPreferences
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
        throw Exception('Failed to update user profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
