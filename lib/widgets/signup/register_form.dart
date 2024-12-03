import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterForm({
    super.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900]!.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white, // Already applied in the container
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
        // Email Field
        _buildModernTextField(
          controller: widget.emailController,
          hintText: 'Email',
          icon: Icons.email_outlined,
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0),

        const SizedBox(height: 10),

        // Username Field
        _buildModernTextField(
          controller: widget.usernameController,
          hintText: 'Username',
          icon: Icons.person_outline,
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0),

        const SizedBox(height: 10),

        // Password Field
        _buildModernTextField(
          controller: widget.passwordController,
          hintText: 'Password',
          icon: Icons.lock_outline,
          obscureText: _isPasswordHidden,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _isPasswordHidden = !_isPasswordHidden;
              });
            },
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0),

        const SizedBox(height: 10),

        // Confirm Password Field
        _buildModernTextField(
          controller: widget.confirmPasswordController,
          hintText: 'Confirm Password',
          icon: Icons.lock_outline,
          obscureText: _isConfirmPasswordHidden,
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordHidden
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
              });
            },
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0),
      ],
    );
  }
}
