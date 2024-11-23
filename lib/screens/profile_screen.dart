import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/services/auth.dart';
import 'package:deteksi_jerawat/services/user-info.dart';
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
  final Auth _auth = Auth();
  final UserInfoService _userInfoService = UserInfoService();

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('No access token found');
      }
      final user = await _userInfoService.fetchUserInfo();
      if (mounted) {
        context.read<UserBloc>().add(FetchUserEvent(token));
      }
    } catch (e) {
      context
          .read<UserBloc>()
          .add(UserErrorEvent('Failed to load user profile: $e'));
    }
  }

  void _handleLogout(BuildContext context) async {
    await _auth.logout();
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
      child: CircularProgressIndicator(
        color: Colors.amber,
        strokeWidth: 4,
      ),
    );
  }

  Widget _buildErrorScreen(UserError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: ${state.message}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _initializeUser,
            child: const Text(
              'Retry',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedScreen(User user) {
    return Container(
      child: Column(
        children: [
          ProfileHeader(user: user),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProgressButton(onPressed: () => _checkProgress(context)),
          ),
          const SizedBox(height: 30),
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
                  onTap: () => _handleLogout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
