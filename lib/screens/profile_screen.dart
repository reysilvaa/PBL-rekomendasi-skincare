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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ProgressButton(
                  onPressed: () => _checkProgress(context),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildMenuItem('Saved', context),
                    _buildMenuItem('Setting', context),
                    _buildMenuItem('Support', context),
                    _buildMenuItem('About us', context),
                    _buildMenuItem('Logout', context, isLogout: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, BuildContext context,
      {bool isLogout = false}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10), // Jarak antar item
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout
                ? Colors.red
                : Colors.black87, // Warna berbeda untuk Logout
          ),
        ),
        onTap: () {
          if (isLogout) {
            _handleLogout(context);
          } else {
            // Handle other menu items
          }
        },
      ),
    );
  }
}
