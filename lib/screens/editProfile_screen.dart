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
    usernameController = TextEditingController(text: widget.user.username);
    phoneNumberController = TextEditingController(text: widget.user.phoneNumber);
    birthDateController = TextEditingController(text: widget.user.birthDate);
    emailController = TextEditingController(text: widget.user.email);
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
  }

  @override
  void dispose() {
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
            // Profile header with image picker
            EditProfileHeader(
              onImagePicked: (newProfileImageUrl) {
                context.read<UserBloc>().add(UpdateProfileImageEvent(newProfileImageUrl));
              },
            ),
            _buildProfileForm(),
            const SizedBox(height: 30),
            _buildSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Profile form fields
  Widget _buildProfileForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username field
          UsernameField(user: widget.user),
          const SizedBox(height: 16),
          // Phone number field
          PhoneNumberField(user: widget.user),
          const SizedBox(height: 16),
          // Birthdate field
          BirthDateField(birthDate: widget.user.birthDate),
          const SizedBox(height: 16),
          // Email field
          EmailField(email: widget.user.email),
          const SizedBox(height: 16),
          // First name field
          FirstNameField(user: widget.user),
          const SizedBox(height: 16),
          // Last name field
          LastNameField(user: widget.user),
        ],
      ),
    );
  }

  // Save button to save the user profile changes
  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SaveButton(
        user: widget.user,
        usernameController: usernameController,
        phoneNumberController: phoneNumberController,
        birthDateController: birthDateController,
        emailController: emailController,
        firstNameController: firstNameController,
        lastNameController: lastNameController,
      ),
    );
  }
}
