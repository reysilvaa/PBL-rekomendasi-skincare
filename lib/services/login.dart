import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const String _baseUrl =
      'http://127.0.0.1:8000/api'; // Corrected the base URL (without '/login')

  // Method to login using JWT
  Future<Map<String, dynamic>> loginUser(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'), // This should point to '/login'
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': login, // This can be email or username
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(
            response.body); // Return the response body (token data)
      } else {
        return {'status': 'error', 'message': 'Invalid credentials'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

  // Method to refresh JWT token
  Future<Map<String, dynamic>> refreshToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/refresh'), // This should point to '/refresh'
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include the old token for refreshing
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return refreshed token data
      } else {
        return {'status': 'error', 'message': 'Failed to refresh token'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

  // Method to logout (clear the stored token)
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token'); // Clear the token
    } catch (e) {
      print('Error clearing the token: $e');
    }
  }
}
