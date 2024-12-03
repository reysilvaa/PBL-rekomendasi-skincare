import 'package:deteksi_jerawat/widgets/signup/register_button.dart';
import 'package:deteksi_jerawat/widgets/signup/register_form.dart';
import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/services/register.dart'; // Import RegisterService
import 'package:deteksi_jerawat/model/user.dart'; // Import the User model
import 'package:deteksi_jerawat/widgets/signup/logo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Function to handle registration
  Future<void> _handleRegistration() async {
    final user = User(
      email: emailController.text.trim(),
      username: usernameController.text.trim(),
      // phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    final result = await registerService.registerUser(user);

    if (result['status'] == 'success') {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      // Optionally navigate to another screen
    } else {
      // Show error message
      print('Error Response: ${result['message']}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
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
              const Logo(),
              const Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 20),
              RegisterForm(
                emailController: emailController,
                usernameController: usernameController,
                // phoneController: phoneController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
              const SizedBox(height: 20),
              // Use RegisterButton and pass the _handleRegistration function
              RegisterButton(onPressed: _handleRegistration),
            ],
          ),
        ),
      ),
    );
  }
}
