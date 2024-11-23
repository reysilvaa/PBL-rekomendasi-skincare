import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    Key? key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isPasswordHidden = true; // State for password visibility
  bool _isConfirmPasswordHidden = true; // State for confirm password visibility

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email Field
        TextField(
          controller: widget.emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Username Field
        TextField(
          controller: widget.usernameController,
          decoration: InputDecoration(
            hintText: 'Username',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Password Field
        TextField(
          controller: widget.passwordController,
          obscureText: _isPasswordHidden, // Toggle visibility
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility, // Change icon
              ),
              onPressed: () {
                setState(() {
                  _isPasswordHidden = !_isPasswordHidden; // Toggle visibility state
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Confirm Password Field
        TextField(
          controller: widget.confirmPasswordController,
          obscureText: _isConfirmPasswordHidden, // Toggle visibility
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility, // Change icon
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordHidden = !_isConfirmPasswordHidden; // Toggle visibility state
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
