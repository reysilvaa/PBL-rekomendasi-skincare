import 'package:cached_network_image/cached_network_image.dart';
import 'package:deteksi_jerawat/model/user.dart';
import 'package:deteksi_jerawat/services/user-info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screens/editProfile_screen.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_state.dart';

class ProfileHeader extends StatelessWidget {
  final User
      user; // Assuming you have a User object that you can pass to the fields

  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        // if (state is UserLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // }

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

          // Get the full image URL using the service
          String profileImageUrl = user.profileImage != null
              ? UserInfoService().getFullImageUrl(user.profileImage!)
              : 'assets/profile/wajah.png'; // Use default if no profile image

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A4BBA), Color(0xFF1257AA)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: SafeArea(
                top: false,
                child: Stack(
                  children: [
                    // Optional decorative pattern on the right
                    Positioned(
                      right: -75,
                      top: 0,
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.5,
                        child: Transform.scale(
                          scaleX: -1,
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/pattern.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Main content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello, ${user.username}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "How's your day?",
                                      style: TextStyle(
                                        color: Colors.white,
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
                                    ? CachedNetworkImageProvider(
                                        profileImageUrl) // Memuat gambar dengan cache
                                    : const AssetImage(
                                            'assets/profile/wajah.png')
                                        as ImageProvider,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 20),
                              ElevatedButton(
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
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      color: Color(0xFF1257AA),
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: Color(0xFF1257AA),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
