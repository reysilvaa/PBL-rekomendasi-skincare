import 'package:deteksi_jerawat/blocs/user/user_event.dart';
import 'package:deteksi_jerawat/blocs/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import 'package:deteksi_jerawat/services/auth.dart';
import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/widgets/editProfile/profile_field.dart';
import 'package:deteksi_jerawat/widgets/editProfile/edit_profile_header.dart';

class EditProfileScreen extends StatefulWidget {
  final User? user;
  const EditProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'username': TextEditingController(),
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'email': TextEditingController(),
    'birthDate': TextEditingController(),
    'gender': TextEditingController(),
  };
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserData();
    });
  }

  Future<void> _initializeUserData() async {
    final token = await Auth().getAccessToken();
    if (token != null) {
      context.read<UserBloc>().add(FetchUserEvent(token));
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _updateFields(User user) {
    setState(() {
      _controllers['username']?.text = user.username;
      _controllers['firstName']?.text = user.firstName ?? '';
      _controllers['lastName']?.text = user.lastName ?? '';
      _controllers['phoneNumber']?.text = user.phoneNumber ?? '';
      _controllers['email']?.text = user.email ?? '';
      _controllers['birthDate']?.text = user.birthDate ?? '';
      _controllers['gender']?.text = user.gender ?? '';
    });
  }

  void _handleProfileUpdate() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final currentState = context.read<UserBloc>().state;
    if (currentState is UserLoaded) {
      final updatedUser = currentState.user.copyWith(
        username: _controllers['username']?.text,
        firstName: _controllers['firstName']?.text,
        lastName: _controllers['lastName']?.text,
        phoneNumber: _controllers['phoneNumber']?.text,
        email: _controllers['email']?.text,
        birthDate: _controllers['birthDate']?.text,
        gender: _controllers['gender']?.text,
        age: _calculateAge(_controllers['birthDate']?.text ?? ''),
      );

      context.read<UserBloc>().add(UpdateUserProfileEvent(updatedUser));
    }
  }

  int _calculateAge(String birthDate) {
    if (birthDate.isEmpty) return 0;
    try {
      final birth = DateTime.parse(birthDate);
      final now = DateTime.now();
      var age = now.year - birth.year;
      if (now.month < birth.month ||
          (now.month == birth.month && now.day < birth.day)) age--;
      return age;
    } catch (_) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserLoaded) {
            setState(() {
              _updateFields(state.user);
            });
          } else if (state is UserUpdated) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')));
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: EditProfileHeader(
                    onImagePicked: (url) => context
                        .read<UserBloc>()
                        .add(UpdateUserFieldEvent('profile_image', url)),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      _controllers['username']?.text =
                          state.user.username ?? '';
                      _controllers['email']?.text = state.user.email ?? '';
                      _controllers['firstName']?.text =
                          state.user.firstName ?? '';
                      _controllers['lastName']?.text =
                          state.user.lastName ?? '';
                      _controllers['phoneNumber']?.text =
                          state.user.phoneNumber ?? '';
                      _controllers['birthDate']?.text =
                          state.user.birthDate ?? '';
                      _controllers['gender']?.text = state.user.gender ?? '';
                      return SliverToBoxAdapter(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              UsernameField(
                                  controller: _controllers['username']!),
                              const SizedBox(height: 16),
                              FirstNameField(
                                  controller: _controllers['firstName']!),
                              const SizedBox(height: 16),
                              LastNameField(
                                  controller: _controllers['lastName']!),
                              const SizedBox(height: 16),
                              PhoneNumberField(
                                  controller: _controllers['phoneNumber']!),
                              const SizedBox(height: 16),
                              EmailField(controller: _controllers['email']!),
                              const SizedBox(height: 16),
                              BirthDateField(
                                  controller: _controllers['birthDate']!),
                              const SizedBox(height: 16),
                              GenderField(
                                initialValue:
                                    _controllers['gender']?.text ?? '',
                                onChanged: (value) {
                                  setState(() {
                                    _controllers['gender']?.text =
                                        value ?? 'GenderLaki';
                                  });
                                },
                              ),
                              // const SizedBox(
                              //     height: 100), // Tambahkan padding bawah
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  },
                ),
              ),
            ],
          );
        },
      ),

      // Tambahkan tombol di bawah layar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _handleProfileUpdate,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0D47A1).withOpacity(0.9),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            animationDuration: Duration(milliseconds: 300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.update),
              SizedBox(width: 10),
              Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
