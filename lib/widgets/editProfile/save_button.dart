import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../model/user.dart';

class SaveButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final TextEditingController birthDateController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String? gender;
  final Level? userLevel;

  const SaveButton({
    super.key,
    required this.usernameController,
    required this.phoneNumberController,
    required this.birthDateController,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    this.gender,
    this.userLevel,
  });

  bool _validateInputs(BuildContext context) {
    // Validate username
    if (usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username cannot be empty')),
      );
      return false;
    }

    // Validate phone number
    if (phoneNumberController.text.isEmpty ||
        phoneNumberController.text.length < 10 ||
        phoneNumberController.text.length > 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return false;
    }

    // Validate birth date
    try {
      DateFormat('yyyy-MM-dd').parse(birthDateController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid birth date format')),
      );
      return false;
    }

    // Validate email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailController.text.isEmpty ||
        !emailRegex.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return false;
    }

    // Validate first name
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('First name cannot be empty')),
      );
      return false;
    }

    // Validate last name
    if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Last name cannot be empty')),
      );
      return false;
    }

    // Validate gender
    if (gender == null || gender!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a gender')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Updating profile...')),
          );
        } else if (state is UserLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
          Navigator.pop(context); // Return to previous page
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to update profile: ${state.message}')),
          );
        }
      },
      child: ElevatedButton(
        onPressed: () {
          // Validate all inputs before proceeding
          if (!_validateInputs(context)) {
            return;
          }

          // Parse and format birth date
          final inputDate =
              DateFormat('yyyy-MM-dd').parse(birthDateController.text);
          final formattedBirthDate = DateFormat('yyyy-MM-dd').format(inputDate);

          // Create updated User object
          final updatedUser = User(
            username: usernameController.text,
            phoneNumber: phoneNumberController.text,
            birthDate: formattedBirthDate,
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            gender: gender, // Use the passed gender
            level: userLevel, // Optional user level
            age: User.calculateAge(formattedBirthDate),
          );

          // Dispatch event to update user profile
          context.read<UserBloc>().add(UpdateUserProfileEvent(updatedUser));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D47A1),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Save',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
