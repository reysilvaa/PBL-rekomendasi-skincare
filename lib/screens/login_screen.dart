import 'package:deteksi_jerawat/widgets/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/widgets/bottom_navigation.dart'; // Import bottom navigation
import 'package:deteksi_jerawat/services/login.dart'; // Import login service
import 'package:deteksi_jerawat/widgets/login/logo.dart'; // Import Logo widget
import 'package:deteksi_jerawat/widgets/login/login_button.dart'; // Import LoginButton widget

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailOrUsername = '';
  String password = '';
  final LoginService _loginService = LoginService();

  void _handleEmailChanged(String newEmail) {
    setState(() {
      emailOrUsername = newEmail;
    });
  }

  void _handlePasswordChanged(String newPassword) {
    setState(() {
      password = newPassword;
    });
  }

  Future<void> _login() async {
    var result = await _loginService.loginUser(emailOrUsername, password);

    if (result['status'] == 'error') {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: Colors.red,
      ));
    } else {
      // Store the token (in your preferred way, like SharedPreferences or Secure Storage)
      String token = result['access_token'];
      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainScreen()), // Replace with your main screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(), // Use the Logo widget here

              const SizedBox(height: 20),

              const Text(
                "Login to Your Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),

              LoginForm(
                onEmailChanged: _handleEmailChanged, // Use the defined method
                onPasswordChanged:
                    _handlePasswordChanged, // Use the defined method
              ),
              const SizedBox(height: 20),

              // Replaced ElevatedButton with LoginButton
              LoginButton(
                onPressed:
                    _login, // Pass the _login function as onPressed callback
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
