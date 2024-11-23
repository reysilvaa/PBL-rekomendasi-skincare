import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../services/user-info.dart';
import '../../screens/editProfile_screen.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserError) {
          return Center(
            child: Text(
              'Failed to load profile: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is UserLoaded) {
          final user = state.user;
          String profileImageUrl = user.profileImage != null
              ? UserInfoService().getFullImageUrl(user.profileImage!)
              : 'assets/profile/wajah.png';

          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1257AA), Color(0xFF1A4BBA)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${user.firstName} 👋',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "How's your day?",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user.profileImage != null
                            ? CachedNetworkImageProvider(profileImageUrl)
                            : const AssetImage('assets/profile/wajah.png')
                                as ImageProvider,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            user: user,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                    ),
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF1257AA),
                      size: 20,
                    ),
                    label: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Color(0xFF1257AA),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
