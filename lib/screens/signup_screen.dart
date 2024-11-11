import 'package:flutter/material.dart';
import '../widgets/signup/login_button.dart';
import '../widgets/signup/logo.dart';
import '../widgets/signup/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Logo(),
              SizedBox(height: 20),
              Text(
                "Crate Your Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 20),
              LoginForm(),
              SizedBox(height: 20),
              LoginButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
