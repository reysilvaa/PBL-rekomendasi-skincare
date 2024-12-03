import 'dart:async';
import 'package:deteksi_jerawat/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/screens/login_screen.dart';
import 'services/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final auth = Auth();
    final isLoggedIn = await auth.isLoggedIn();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Pure white background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/login/logo.png', // Logo image file path
                width: 120, // Adjust the size as needed
                height: 120,
              ),
              const SizedBox(height: 10),
              const Text(
                "Find your Recommendation!", // Tagline text
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0D47A1), // Dark gray for a subtle contrast
                  fontFamily: 'IsidoraSansAlt', // Elegant serif font
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
