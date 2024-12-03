import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/services/auth.dart'; // Gunakan auth_service.dart
import 'package:deteksi_jerawat/services/user-info.dart'; // Gunakan user-info.dart
import 'package:deteksi_jerawat/widgets/profile/menu_item.dart';
import 'package:deteksi_jerawat/widgets/profile/profile_header.dart';
import 'package:deteksi_jerawat/widgets/profile/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Auth _auth = Auth(); // Buat instance dari Auth
  final UserInfoService _userInfoService =
      UserInfoService(); // Instance UserInfoService

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      final token = await _auth.getAccessToken(); // Ambil token melalui Auth

      if (token == null) {
        throw Exception('No access token found');
      }

      final user =
          await _userInfoService.fetchUserInfo(); // Ambil data pengguna

      if (mounted) {
        // Dispatch event dengan data pengguna
        context.read<UserBloc>().add(FetchUserEvent(token));
      }
    } catch (e) {
      context
          .read<UserBloc>()
          .add(UserErrorEvent('Failed to load user profile: $e'));
    }
  }

  void _handleLogout(BuildContext context) async {
    await _auth.logout(context); // Passing context ke method logout

    // Arahkan ke layar login
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
          builder: (context, state) {
            if (state is UserLoading) {
              return _buildLoadingScreen();
            }
            if (state is UserError) {
              return _buildErrorScreen(state);
            }
            if (state is UserLoaded) {
              return _buildLoadedScreen(state.user);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
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
            onPressed: _initializeUser,
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
          ProfileHeader(user: user),
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
                  onTap: () =>
                      _handleLogout(context), // Logout melalui _handleLogout
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
