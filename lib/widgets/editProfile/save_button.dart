import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/services/auth.dart';
import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/widgets/editProfile/profile_field.dart';
import 'package:deteksi_jerawat/widgets/editProfile/edit_profile_header.dart';

class SaveProfileButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SaveProfileButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isLoading ? 60 : double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isLoading ? Colors.grey : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
