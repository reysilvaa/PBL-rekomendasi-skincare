import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  // final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    Key? key,
    required this.emailController,
    required this.usernameController,
    // required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        // TextField(
        //   controller: phoneController,
        //   decoration: const InputDecoration(labelText: 'Phone'),
        // ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
        ),
        TextField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Confirm Password'),
        ),
      ],
    );
  }
}
