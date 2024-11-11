import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;

  const LoginForm({
    Key? key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  String email = '';
  String password = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            email = value;
            widget.onEmailChanged(value); // Notify the parent widget
          },
          decoration: InputDecoration(
            hintText: 'Username or email',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: _obscurePassword,
          onChanged: (value) {
            password = value;
            widget.onPasswordChanged(value); // Notify the parent widget
          },
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
