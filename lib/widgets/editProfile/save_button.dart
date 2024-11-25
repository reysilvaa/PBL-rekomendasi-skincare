import 'package:deteksi_jerawat/services/user-info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/user.dart';

class SaveButton extends StatelessWidget {
  final User user;
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final TextEditingController birthDateController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const SaveButton({
    Key? key,
    required this.user,
    required this.usernameController,
    required this.phoneNumberController,
    required this.birthDateController,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final userInfoService = UserInfoService();

        // Validate birth date format
        String? formattedBirthDate;
        try {
          // Try parsing the input to ensure it's a valid date
          final inputDate = DateFormat('yyyy-MM-dd').parse(birthDateController.text);
          formattedBirthDate = DateFormat('yyyy-MM-dd').format(inputDate);
        } catch (e) {
          // Show error if date is invalid
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid birth date format')),
          );
          return;
        }

        // Membuat objek user baru dengan data yang diperbarui
        final updatedUser = User(
          username: usernameController.text,
          phoneNumber: phoneNumberController.text,
          birthDate: formattedBirthDate,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
        );

        try {
          // Panggil API untuk memperbarui data user
          await userInfoService.updateUserProfile(updatedUser);

          // Tampilkan pesan keberhasilan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );

          // Kembali ke halaman sebelumnya
          Navigator.pop(context);
        } catch (e) {
          // Tampilkan pesan error jika gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: $e')),
          );
        }
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}