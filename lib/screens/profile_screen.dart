import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/services/access_token.dart';
import 'package:deteksi_jerawat/widgets/profile/menu_item.dart';
import 'package:deteksi_jerawat/widgets/profile/profile_header.dart';
import 'package:deteksi_jerawat/widgets/profile/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import 'login_screen.dart';
import '../services/user-info.dart'; // Import the UserInfoService class

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      final userInfoService =
          UserInfoService(); // Create instance of the service
      final token =
          await getAccessToken(); // Retrieve token using getAccessToken()

      if (token == null) {
        throw Exception('No access token found');
      }

      final user = await userInfoService
          .fetchUserInfo(); // Fetch user info using the token

      // After fetching the user data, dispatch the UserLoaded event
      if (mounted) {
        context
            .read<UserBloc>()
            .add(FetchUserEvent(token)); // Dispatch event with token
      }
    } catch (e) {
      // Handle error if fetching user info fails
      context
          .read<UserBloc>()
          .add(UserErrorEvent('Failed to load user profile'));
    }
  }

  void _handleLogout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _checkProgress(BuildContext context) {
    print('Checking progress...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          // Using BlocBuilder to listen to UserBloc states
          builder: (context, state) {
            if (state is UserLoading) {
              return _buildLoadingScreen(); // Show loading screen
            }
            if (state is UserError) {
              return _buildErrorScreen(state); // Show error message
            }
            if (state is UserLoaded) {
              return _buildLoadedScreen(
                  state.user); // Show profile screen with user data
            }
            return const SizedBox
                .shrink(); // Return an empty widget while the state is uninitialized
          },
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: CircularProgressIndicator(), // Show loading indicator
    );
  }

  Widget _buildErrorScreen(UserError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: ${state.message}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _initializeUser, // Retry fetching user data
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedScreen(User user) {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          ProfileHeader(user: user), // Display user info in profile header
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ProgressButton(onPressed: () => _checkProgress(context)),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                MenuItem(title: 'Saved', onTap: () {}),
                MenuItem(title: 'Setting', onTap: () {}),
                MenuItem(title: 'Support', onTap: () {}),
                MenuItem(title: 'About us', onTap: () {}),
                MenuItem(
                  title: 'Logout',
                  isLogout: true,
                  onTap: () => _handleLogout(context), // Handle logout action
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
