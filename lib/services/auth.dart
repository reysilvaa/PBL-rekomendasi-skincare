import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static const int sessionDuration = 3600; // Durasi sesi dalam detik (1 jam)

  // Menyimpan access token dan waktu login
  Future<void> storeAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final loginTime = DateTime.now().millisecondsSinceEpoch; 

    await prefs.setString('access_token', token);
    await prefs.setInt('login_time', loginTime);
  }

  // Mengambil access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Mengecek waktu login terakhir
  Future<int?> getLastLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('login_time');
  }

  // Memperbarui waktu login
  Future<void> updateLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('login_time', currentTime);
  }

  // Internal method untuk membersihkan sesi
  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('login_time');
  }

  // Method logout untuk UI dengan navigasi
  Future<void> logout(BuildContext context) async {
    await _clearSession();
    // Navigasi ke halaman login dan hapus semua route sebelumnya
    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/login',
      (route) => false, // Ini akan menghapus semua route dari stack
    );
  }

  // Mengecek apakah user sudah login dan sesi masih valid
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final loginTime = prefs.getInt('login_time');

    if (token == null || loginTime == null) {
      return false;
    }

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final sessionDurationMillis = sessionDuration * 1000; // Konversi ke milliseconds
    final isSessionValid = (currentTime - loginTime) < sessionDurationMillis;

    if (!isSessionValid) {
      await _clearSession(); // Bersihkan sesi jika sudah kadaluarsa
      return false;
    }

    return true;
  }

  // Method untuk auto logout jika sesi habis
  Future<void> checkAndHandleSessionExpiration(BuildContext context) async {
    if (!await isLoggedIn()) {
      // Tampilkan dialog sesi berakhir
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sesi Berakhir'),
            content: const Text(
              'Sesi Anda telah berakhir. Silakan login kembali.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  logout(context); // Logout dan navigasi ke halaman login
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Method untuk refresh token (jika diperlukan)
  Future<bool> refreshToken() async {
    try {
      // Implementasi refresh token di sini
      // Contoh:
      // final response = await apiService.refreshToken();
      // if (response.success) {
      //   await storeAccessToken(response.newToken);
      //   return true;
      // }
      return false;
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }

  // Method untuk mengecek apakah token perlu di-refresh
  Future<bool> shouldRefreshToken() async {
    final loginTime = await getLastLoginTime();
    if (loginTime == null) return false;

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeElapsed = currentTime - loginTime;
    // Refresh jika sesi sudah berjalan lebih dari 45 menit (75% dari sessionDuration)
    return timeElapsed > (sessionDuration * 1000 * 0.75);
  }
}

// Extension untuk kemudahan penggunaan
extension AuthContextExtension on BuildContext {
  Future<void> checkSession() async {
    final auth = Auth();
    await auth.checkAndHandleSessionExpiration(this);
  }
}