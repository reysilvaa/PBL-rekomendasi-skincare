import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth.dart'; // Pastikan mengimpor auth_service.dart

class LoginService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api'; // URL dasar API
  final Auth _auth = Auth(); // Membuat instansi dari Auth

  // Method untuk login menggunakan JWT
  Future<Map<String, dynamic>> loginUser(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'), // Endpoint untuk login
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': login, // Bisa berupa email atau username
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String accessToken = responseData['access_token'];

        // Simpan access token menggunakan Auth
        await _auth.storeAccessToken(accessToken);

        return responseData; // Kembalikan data respons
      } else {
        return {'status': 'error', 'message': 'Invalid credentials'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

  // Method untuk refresh token JWT
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      final token = await _auth.getAccessToken(); // Ambil token saat ini

      if (token == null) {
        return {'status': 'error', 'message': 'No token available for refresh'};
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/refresh'), // Endpoint untuk refresh token
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> refreshedToken = jsonDecode(response.body);
        final String newAccessToken = refreshedToken['access_token'];

        // Simpan token baru menggunakan Auth
        await _auth.storeAccessToken(newAccessToken);

        return refreshedToken;
      } else {
        return {'status': 'error', 'message': 'Failed to refresh token'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }

  // Method untuk logout (menghapus token yang tersimpan)
  Future<void> logout() async {
    try {
      await _auth
          .logout(); // Panggil metode logout dari Auth untuk menghapus token
    } catch (e) {
      print('Error clearing the token: $e');
    }
  }
}
