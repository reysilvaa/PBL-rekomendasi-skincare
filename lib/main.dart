import 'package:flutter/material.dart';
import './screens/home_screen.dart'; // Import HomeScreen
import './screens/camera_screen.dart'; // Import CameraScreen
import './widgets/home/bottom_navigation.dart'; // Import CameraScreen

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
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => MainScreen(), // Main screen with bottom navigation
        '/home': (context) => HomeScreen(), // Home route
        '/scan': (context) => CameraScreen(), // Scan route
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
  int _selectedIndex = 0; // Track the current tab

  // Define the screens for each tab
  final List<Widget> _screens = [
    HomeScreen(),
    Center(child: Text('Schedule')), // Temporary placeholder
    CameraScreen(),
    Center(child: Text('Community')), // Temporary placeholder
    Center(child: Text('Profile')), // Temporary placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
