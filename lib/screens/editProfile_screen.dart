import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/widgets/editProfile/edit_profile_header.dart';
import 'package:deteksi_jerawat/widgets/editProfile/username.dart';
import 'package:deteksi_jerawat/widgets/editProfile/first_name.dart';
import 'package:deteksi_jerawat/widgets/editProfile/last_name.dart';
import 'package:deteksi_jerawat/widgets/editProfile/email.dart';
import 'package:deteksi_jerawat/widgets/editProfile/phone_number.dart';
import 'package:deteksi_jerawat/widgets/editProfile/birth_date.dart';
import 'package:deteksi_jerawat/widgets/editProfile/save_button.dart';
import '../model/user.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController phoneNumberController;
  late TextEditingController birthDateController;
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    usernameController = TextEditingController(text: widget.user.username);
    phoneNumberController = TextEditingController(text: widget.user.phoneNumber);
    birthDateController = TextEditingController(text: widget.user.birthDate);
    emailController = TextEditingController(text: widget.user.email);
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    usernameController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

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
            // Image Picker and Upload
            EditProfileHeader(
              onImagePicked: (newProfileImageUrl) {
                context
                    .read<UserBloc>()
                    .add(UpdateProfileImageEvent(newProfileImageUrl));
              },
            ),
            _buildProfileForm(),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // Profile form fields
  Widget _buildProfileForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UsernameField(user: widget.user),
          const SizedBox(height: 20),
          PhoneNumberField(user: widget.user),
          const SizedBox(height: 20),
          BirthDateField(birthDate: widget.user.birthDate),
          const SizedBox(height: 20),
          EmailField(email: widget.user.email),
          const SizedBox(height: 20),
          FirstNameField(user: widget.user),
          const SizedBox(height: 20),
          LastNameField(user: widget.user),
        ],
      ),
    );
  }

  // Save button to save the user profile changes
  Widget _buildSaveButton() {
    return SaveButton(
      user: widget.user,
      usernameController: usernameController,
      phoneNumberController: phoneNumberController,
      birthDateController: birthDateController,
      emailController: emailController,
      firstNameController: firstNameController,
      lastNameController: lastNameController,
    );
  }
}
