import 'package:flutter/material.dart';
import '../widgets/login/logo.dart';
import '../widgets/login/login_form.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/sign_up_link.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                "Login to Your Account",
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
              SignUpLink(),
            ],
          ),
        ),
      ),
    );
  }
}
