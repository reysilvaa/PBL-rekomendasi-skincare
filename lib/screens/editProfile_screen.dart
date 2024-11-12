import 'package:flutter/material.dart';
import '../widgets/editProfile/username.dart';
import '../widgets/editProfile/first_name.dart';
import '../widgets/editProfile/last_name.dart';
import '../widgets/editProfile/email.dart';
import '../widgets/editProfile/phone_number.dart';
import '../widgets/editProfile/birth_date.dart';
import '../model/user.dart';

class EditProfileScreen extends StatelessWidget {
  final User user;

  const EditProfileScreen({
    super.key,
    required this.user, // Pass user directly
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        width: double.infinity,
        color: const Color(0xFF0D47A1),
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile/wajah.png'),
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () {
                // Add functionality to change profile picture
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          UsernameField(user: user),
          const SizedBox(height: 20),
          PhoneNumberField(user: user),
          const SizedBox(height: 20),
          BirthDateField(birthDate: user.birthDate),
          const SizedBox(height: 20),
          EmailField(email: user.email),
          const SizedBox(height: 20),
          FirstNameField(user: user), // Correctly passing the full user object
          const SizedBox(height: 20),
          LastNameField(user: user), // Correctly passing the full user object
        ],
      ),
    );
  }
}
