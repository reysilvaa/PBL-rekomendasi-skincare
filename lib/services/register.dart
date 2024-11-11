import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:deteksi_jerawat/model/user.dart'; // Import the User model

class RegisterService {
  final String apiUrl = 'http://127.0.0.1:8000/api/register';

  // Function to handle the registration process
  Future<Map<String, dynamic>> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': user.email,
          'username': user.username,
          'password': user.password,
          'password_confirmation': user.confirmPassword,
        }),
      );

      // Log the response body for debugging purposes
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Check if the response status is 201 (Created)
      if (response.statusCode == 201) {
        return {'status': 'success', 'message': 'Registration successful'};
      } else {
        // Parse the response and return the error message
        final responseData = jsonDecode(response.body);
        return {
          'status': 'error',
          'message': responseData['message'] ?? 'Unknown error'
        };
      }
    } catch (e) {
      // If any error occurs (e.g., network error, timeout), catch it and return an error message
      return {
        'status': 'error',
        'message': 'Failed to connect to the server. Please try again later.'
      };
    }
  }
}

// Initialize the RegisterService instance
final registerService = RegisterService();
