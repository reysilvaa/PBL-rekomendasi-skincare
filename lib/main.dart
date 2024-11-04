import 'package:deteksi_jerawat/screens/history/recommendation_screen.dart';
import 'package:deteksi_jerawat/screens/history_screen.dart';
import 'package:deteksi_jerawat/screens/profile_screen.dart';
import 'package:deteksi_jerawat/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/camera_screen.dart';

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
      // Hapus home: MainScreen(), karena kita sudah menentukan initialRoute
      home: MainScreen(),
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
}
