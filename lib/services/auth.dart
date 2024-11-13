// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static const int sessionDuration = 3600; // Durasi sesi dalam detik (1 jam)

  // Menyimpan access token dan waktu login
  Future<void> storeAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final loginTime =
        DateTime.now().millisecondsSinceEpoch; // Waktu login saat ini

    await prefs.setString('access_token', token);
    await prefs.setInt('login_time', loginTime); // Simpan waktu login
  }

  // Mengambil access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Mengecek apakah user sudah login dan apakah sesi masih valid
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final loginTime = prefs.getInt('login_time');

    if (token == null || loginTime == null) {
      return false;
    }

    // Cek apakah sesi sudah habis
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final isSessionValid = (currentTime - loginTime) < (sessionDuration * 1000);

    // Jika sesi sudah kadaluarsa, hapus token dan waktu login
    if (!isSessionValid) {
      await logout();
      return false;
    }

    return true;
  }

  // Menghapus access token dan waktu login (untuk logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('login_time');
  }
}
