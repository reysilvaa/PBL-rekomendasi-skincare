import 'package:flutter/material.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/progress_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _handleLogout(BuildContext context) {
    print('Logging out...');
  }

  void _checkProgress(BuildContext context) {
    print('Checking progress...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[50], // Warna latar belakang yang lembut
          child: Column(
            children: [
              const ProfileHeader(
                name: 'Abima Fadricha',
                imageUrl: 'assets/profile_image.jpg',
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
