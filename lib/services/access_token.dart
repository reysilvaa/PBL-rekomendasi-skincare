import 'package:shared_preferences/shared_preferences.dart';

// Store the access token
Future<void> storeAccessToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', token);
}

// Retrieve the access token
Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}
