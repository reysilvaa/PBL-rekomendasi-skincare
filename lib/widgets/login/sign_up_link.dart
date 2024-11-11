import 'package:flutter/material.dart';
import '../../screens/signup_screen.dart'; // Pastikan untuk mengimpor SignUpScreen

class SignUpLink extends StatelessWidget {
  const SignUpLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Doesn’t have an account? "),
        GestureDetector(
          onTap: () {
            // Navigasi ke halaman Sign Up
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xFF0D47A1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
