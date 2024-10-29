import 'package:deteksi_jerawat/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/camera_screen.dart';
import 'widgets/bottom_navigation.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(), // Entry point of the app
        '/home': (context) => HomeScreen(),
        '/scan': (context) => CameraScreen(), // Route untuk CameraScreen
        '/profile': (context) => ProfileScreen(), // Route untuk CameraScreen
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Track the tab index

  final List<Widget> _screens = [
    HomeScreen(), // Home screen
    Center(child: Text('Schedule')), // Placeholder for Schedule screen
    CameraScreen(), // Home screen
    Center(child: Text('Community')), // Placeholder for Community screen
    ProfileScreen(), // Home screen
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index; // Update index
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
