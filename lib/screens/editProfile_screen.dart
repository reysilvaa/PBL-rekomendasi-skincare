import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/blocs/user/user_state.dart';
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
            EditProfileHeader(
              onImagePicked: (newProfileImageUrl) {
                context
                    .read<UserBloc>()
                    .add(UpdateProfileImageEvent(newProfileImageUrl));
              },
            ),
            _buildProfileForm(context),
            const SizedBox(height: 20),
            _buildSaveButton(context),
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
          LastNameField(user: widget.user), // Passing User object to LastNameField
        ],
      ),
    );
  }
  Widget _buildSaveButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      final updatedUser = User(
        username: usernameController.text,
        phoneNumber: phoneNumberController.text,
        birthDate: birthDateController.text,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      );

     
      context.read<UserBloc>().add(UpdateUserProfileEvent(updatedUser));

     
      final userState = context.read<UserBloc>().state;

      if (userState is UserUpdated) {
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context); 
      } else if (userState is UserError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile. Try again.')),
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
