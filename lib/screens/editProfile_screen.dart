import 'package:deteksi_jerawat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/blocs/user/user_state.dart';
import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/widgets/editProfile/profile_field.dart';
import 'package:deteksi_jerawat/widgets/editProfile/edit_profile_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late Future<String?> accessToken; // Declare a future for access token

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;

  String? _selectedGender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _usernameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _birthDateController = TextEditingController();

    // Fetch access token
    accessToken = Auth().getAccessToken();

    // Fetch user data after getting access token
    _fetchUserData();
  }

  // Fetch user data asynchronously
  Future<void> _fetchUserData() async {
    final token = await accessToken;

    if (token != null) {
      context.read<UserBloc>().add(FetchUserEvent(token));
    } else {
      // Handle case when the access token is not available
      _showMessageDialog('Error', 'User is not logged in');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _updateControllers(User user) {
    setState(() {
      _usernameController.text = user.username;
      _firstNameController.text = user.firstName!;
      _lastNameController.text = user.lastName!;
      _phoneNumberController.text = user.phoneNumber!;
      _emailController.text = user.email!;
      _birthDateController.text = user.birthDate!;
      _selectedGender = user.gender;
    });
  }

  void _updateProfile(User currentUser) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final updatedUser = User(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text,
        birthDate: _birthDateController.text,
        gender: _selectedGender,
        level: currentUser.level,
        age: _calculateAge(_birthDateController.text),
        profileImage: currentUser.profileImage,
      );

      context.read<UserBloc>().add(UpdateUserProfileEvent(updatedUser));
    } catch (e) {
      _showMessageDialog('Error', 'Failed to update profile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  int _calculateAge(String birthDateString) {
    if (birthDateString.isEmpty) return 0;

    try {
      final birthDate = DateTime.parse(birthDateString);
      final currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;

      if (currentDate.month < birthDate.month ||
          (currentDate.month == birthDate.month &&
              currentDate.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      return 1;
    }
  }

  void _showMessageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  void _updateProfileImage(String newImageUrl) {
    context
        .read<UserBloc>()
        .add(UpdateUserFieldEvent('profile_image', newImageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            current is UserLoaded ||
            current is UserError ||
            current is UserUpdated,
        listener: (context, state) {
          if (state is UserError) {
            _showMessageDialog('Error', state.message);
          } else if (state is UserLoaded) {
            _updateControllers(state.user);
          } else if (state is UserUpdated) {
            _showMessageDialog('Success', 'Profile updated successfully');
            _updateControllers(state.updatedUser);
          }
        },
        buildWhen: (previous, current) =>
            current is UserLoaded ||
            current is UserLoading ||
            current is UserError,
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            );
          }

          if (state is UserError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }

          final user = state is UserLoaded
              ? state.user
              : (state is UserUpdated)
                  ? (state as UserUpdated).updatedUser
                  : null;

          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: EditProfileHeader(
                    onImagePicked: _updateProfileImage,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildProfileFormFields(user),
                        const SizedBox(height: 24),
                        _buildUpdateProfileButton(user),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileFormFields(User user) {
    return Column(
      children: [
        UsernameField(controller: _usernameController),
        const SizedBox(height: 16),
        FirstNameField(controller: _firstNameController),
        const SizedBox(height: 16),
        LastNameField(controller: _lastNameController),
        const SizedBox(height: 16),
        PhoneNumberField(controller: _phoneNumberController),
        const SizedBox(height: 16),
        EmailField(controller: _emailController),
        const SizedBox(height: 16),
        BirthDateField(controller: _birthDateController),
        const SizedBox(height: 16),
        GenderField(
          initialValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
        const SizedBox(height: 16),
        UserLevelField(
          user: user,
          onChanged: null,
        ),
      ],
    );
  }

  Widget _buildUpdateProfileButton(User user) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _updateProfile(user),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text(
              'Update Profile',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
    );
  }
}
