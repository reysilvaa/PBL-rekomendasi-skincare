import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/camera_screen.dart';
import './widgets/home/bottom_navigation.dart';

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
        '/': (context) => MainScreen(),
        '/home': (context) => HomeScreen(),
        '/scan': (context) => CameraScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    Center(child: Text('Schedule')), // route
    CameraScreen(),
    Center(child: Text('Community')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0; // Track the tab index locally

    return StatefulBuilder(
      builder: (context, setState) {
        return Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigation(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index; // Update index using StatefulBuilder
              });
            },
          ),
        );
      },
    );
  }
}
