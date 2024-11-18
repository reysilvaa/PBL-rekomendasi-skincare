import 'package:deteksi_jerawat/services/user-info.dart';
import 'package:flutter/material.dart';
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

        // Membuat objek user baru dengan data yang diperbarui
        final updatedUser = User(
          username: usernameController.text,
          phoneNumber: phoneNumberController.text,
          birthDate: birthDateController.text,
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
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
      ),
      child: const Text(
        'Save',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
