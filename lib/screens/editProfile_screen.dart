import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/widgets/editProfile/edit_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            EditProfileHeader(
              onImagePicked: (newProfileImageUrl) {
                context
                    .read<UserBloc>()
                    .add(UpdateProfileImageEvent(newProfileImageUrl));
              },
            ),
            _buildProfileForm(context),
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
          FirstNameField(user: user),
          const SizedBox(height: 20),
          LastNameField(user: user),
        ],
      ),
    );
  }
}
