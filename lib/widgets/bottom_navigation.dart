import 'package:deteksi_jerawat/blocs/scan/scan_bloc.dart';
import 'package:deteksi_jerawat/screens/camera_screen.dart';
import 'package:deteksi_jerawat/screens/history_screen.dart';
import 'package:deteksi_jerawat/screens/home_screen.dart';
import 'package:deteksi_jerawat/screens/profile_screen.dart';
import 'package:deteksi_jerawat/screens/skinpedia_screen.dart';
import 'package:deteksi_jerawat/services/scan-post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/services/auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final Auth _auth = Auth();
  late final ScanBloc _scanBloc;

  @override
  void initState() {
    super.initState();
    _scanBloc = ScanBloc(scanService: ScanService());
  }

  @override
  void dispose() {
    _scanBloc.close();
    super.dispose();
  }

  // List of screens excluding camera
  final List<Widget> _screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const SizedBox(), // Placeholder for camera
    SkinpediaScreen(),
    const ProfileScreen(),
  ];

  Future<void> _navigateToCamera() async {
    try {
      final token = await _auth.getAccessToken();
      if (token != null) {
        if (!mounted) return;

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _scanBloc,
              child: CameraScreen(token: token),
            ),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to use the camera')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      _navigateToCamera();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF0046BE),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              activeIcon: Icon(Icons.event_note),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Color(0xFF0046BE),
                radius: 25,
                child: Icon(
                  Icons.document_scanner_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book),
              label: 'Skinpedia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
