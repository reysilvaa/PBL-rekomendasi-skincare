import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UserInfoService {
  final String baseUrl =
      'http://127.0.0.1:8000/api'; // Replace with your local IP for device testing

  Future<User> fetchUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile-info'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Debugging: print the response status and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Request URL: ${Uri.parse('$baseUrl/user/profile-info')}');
      print('Authorization: Bearer $token');

      if (response.statusCode == 200) {
        // Parse the response as a JSON object
        final Map<String, dynamic> data = json.decode(response.body);

        // Extract 'user' data if it exists and parse it into User model
        if (data['user'] != null) {
          final userData = data['user'];
          return User.fromJson(
              userData); // Assuming your User model has a fromJson factory
        } else {
          throw Exception('User data not found in the response.');
        }
      } else {
        throw Exception('Failed to fetch user info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e'); // Log any network or parsing errors
      throw Exception('Network error: $e');
    }
  }
}
