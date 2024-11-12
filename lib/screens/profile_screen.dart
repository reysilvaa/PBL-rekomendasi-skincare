import 'package:deteksi_jerawat/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/progress_button.dart';
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
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      if (mounted) {
        context.read<UserBloc>().add(FetchUserEvent(token));
      }
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
          builder: (context, state) {
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
