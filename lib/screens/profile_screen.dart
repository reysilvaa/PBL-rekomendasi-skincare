import 'package:flutter/material.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/progress_button.dart';
import '../model/profile_model.dart';
import '../screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileModel profile = ProfileModel(
    name: 'Abima Fadricho',
    imageUrl: 'assets/profile/wajah.png',
  );

  ProfileScreen({Key? key}) : super(key: key);

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
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              ProfileHeader(
                name: profile.name,
                imageUrl: profile.imageUrl,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ProgressButton(
                  onPressed: () => _checkProgress(context),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    MenuItem(
                      title: 'Saved',
                      onTap: () {
                        // Handle saved items
                      },
                    ),
                    MenuItem(
                      title: 'Setting',
                      onTap: () {
                        // Handle settings
                      },
                    ),
                    MenuItem(
                      title: 'Support',
                      onTap: () {
                        // Handle support
                      },
                    ),
                    MenuItem(
                      title: 'About us',
                      onTap: () {
                        // Handle about
                      },
                    ),
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
        ),
      ),
    );
  }
}
