import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginForm extends StatefulWidget {
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;

  const LoginForm({
    super.key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
  });

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

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    required Function(String) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          hintText: 'Username or email',
          icon: Icons.email_outlined,
          onChanged: (value) {
            email = value;
            widget.onEmailChanged(value);
          },
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0),
        _buildTextField(
          hintText: 'Password',
          icon: Icons.lock_outline,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: _togglePasswordVisibility,
          ),
          onChanged: (value) {
            password = value;
            widget.onPasswordChanged(value);
          },
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0),
      ],
    );
  }
}

// ... (rest of the code remains the same as in the previous response)