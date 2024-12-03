import 'package:deteksi_jerawat/screens/signup_screen.dart';
import 'package:deteksi_jerawat/widgets/login/login_form.dart';
import 'package:deteksi_jerawat/widgets/login/sign_up_link.dart';
import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/widgets/bottom_navigation.dart'; // Import bottom navigation
import 'package:deteksi_jerawat/services/login.dart'; // Import login service
import 'package:deteksi_jerawat/widgets/login/logo.dart'; // Import Logo widget
import 'package:deteksi_jerawat/widgets/login/login_button.dart'; // Import LoginButton widget
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailOrUsername = '';
  String password = '';
  final LoginService _loginService = LoginService();
  bool _isLoading = false; // State untuk melacak proses loading

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

  Future<void> _storeAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Mulai loading
    });

    var result = await _loginService.loginUser(emailOrUsername, password);

    setState(() {
      _isLoading = false; // Selesai loading
    });

    if (result['status'] == 'error') {
      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        backgroundColor: Colors.red,
      ));
    } else {
      // Simpan token di SharedPreferences
      String token = result['access_token'];
      await _storeAccessToken(token);

      // Navigasi ke layar berikutnya (MainScreen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const MainScreen(), // Ganti dengan MainScreen Anda
        ),
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
              const Logo(), // Gunakan widget Logo di sini

              const SizedBox(height: 20),

              const Text(
                "Login to Your Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Welcome back! Please enter your credentials to continue.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF616161),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              LoginForm(
                onEmailChanged:
                    _handleEmailChanged, // Gunakan metode yang sudah didefinisikan
                onPasswordChanged:
                    _handlePasswordChanged, // Gunakan metode yang sudah didefinisikan
              ),
              const SizedBox(height: 30),

              _isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF1A237E)),
                    ) // Tampilkan indikator loading saat _isLoading true
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A237E),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF616161)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke layar SignUpScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SignUpScreen(), // Ganti dengan layar SignUpScreen Anda
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
