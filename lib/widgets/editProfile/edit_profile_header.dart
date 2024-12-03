import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';
import '../../blocs/user/user_state.dart';
import '../../services/auth.dart';
import '../../services/edit-profile-image-post.dart';
import '../../services/user-info.dart';

class EditProfileHeader extends StatefulWidget {
  final Function(String) onImagePicked;

  const EditProfileHeader({
    super.key,
    required this.onImagePicked,
  });

  @override
  State<EditProfileHeader> createState() => _EditProfileHeaderState();
}

class _EditProfileHeaderState extends State<EditProfileHeader>
    with SingleTickerProviderStateMixin {
  bool isUploading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the widget is first built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return FadeIn(
          duration: const Duration(milliseconds: 600),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF0D47A1).withOpacity(0.9),
                        const Color(0xFF1565C0),
                      ],
                      stops: const [0.3, 1],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Profile Image Container
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.8),
                                  Colors.white.withOpacity(0.6),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 3,
                              ),
                            ),
                            child: _buildProfileImage(state),
                          ),

                          // Upload Progress Overlay
                          if (isUploading)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ),
                            ),

                          // Camera Icon
                          if (!isUploading)
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: () => _handleImagePicker(context),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF0D47A1)
                                            .withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 24,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        isUploading ? 'Uploading...' : 'Edit Profile Picture',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(UserState state) {
    if (state is UserLoaded) {
      final profileImageUrl = state.user.profileImage != null
          ? UserInfoService().getFullImageUrl(state.user.profileImage!)
          : null;

      if (profileImageUrl != null) {
        return ClipOval(
          child: CachedNetworkImage(
            imageUrl: profileImageUrl,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(
              Icons.person,
              size: 50,
              color: Colors.grey,
            ),
          ),
        );
      }
    }

    return const Icon(
      Icons.person,
      size: 50,
      color: Colors.grey,
    );
  }

  Future<void> _handleImagePicker(BuildContext context) async {
    try {
      setState(() {
        isUploading = true;
      });

      final token = await Auth().getAccessToken();
      if (token == null) {
        throw Exception('No access token found');
      }

      final newProfileImageUrl =
          await ProfileImagePOST().pickImageAndUpload(token);

      if (!mounted) return;

      // Update the BLoC state with the new image URL
      context.read<UserBloc>().add(
            UpdateUserFieldEvent('profile_image', newProfileImageUrl),
          );

      // Notify parent widget about the new image URL
      widget.onImagePicked(newProfileImageUrl);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isUploading = false;
        });
      }
    }
  }
}
