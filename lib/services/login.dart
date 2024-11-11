import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String _baseUrl =
      'http://127.0.0.1:8000/api'; // Corrected the base URL (without '/login')

  // Method to login using JWT
  Future<Map<String, dynamic>> loginUser(String login, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'), // This should point to '/login'
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'login': login, // This can be email or username
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the response body (token data)
    } else {
      return {'status': 'error', 'message': 'Invalid credentials'};
    }
  }

  // Method to refresh JWT token
  Future<Map<String, dynamic>> refreshToken(String token) async {
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
  }
}
