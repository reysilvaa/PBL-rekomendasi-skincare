import 'package:deteksi_jerawat/screens/history/recommendation_screen.dart';
import 'package:deteksi_jerawat/screens/history_screen.dart';
import 'package:deteksi_jerawat/screens/profile_screen.dart';
import 'package:deteksi_jerawat/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/camera_screen.dart';
import './screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1a5fab),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future:
            _checkLoginStatus(), // Check login status before building the UI
        builder: (context, snapshot) {
          // Show a loading indicator while checking the login status
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }

          // If the user is logged in, show the MainScreen, otherwise, show the LoginScreen
          if (snapshot.data == true) {
            return MainScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/scan': (context) => CameraScreen(),
        '/profile': (context) => ProfileScreen(),
        '/history': (context) => HistoryScreen(),
        '/history/rekomendasi': (context) => RecommendationScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }

  // Method to check if the user is logged in
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Check if the access token exists
    String? token = prefs.getString('access_token');
    return token != null; // If token is not null, user is logged in
  }
}
