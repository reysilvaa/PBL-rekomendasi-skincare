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

class _EditProfileHeaderState extends State<EditProfileHeader> {
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          // Data Profil sudah dimuat, tampilkan UI
          return _buildProfileHeader(state);
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink(); // Fallback jika state tidak sesuai
      },
    );
  }

  Widget _buildProfileHeader(UserLoaded state) {
    final profileImageUrl = state.user.profileImage != null
        ? UserInfoService().getFullImageUrl(state.user.profileImage!)
        : null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0D47A1).withOpacity(0.9),
            const Color(0xFF1565C0),
          ],
          stops: const [0.3, 1],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          // Gambar Profil
          Stack(
            alignment: Alignment.center,
            children: [
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
                child: _buildProfileImage(profileImageUrl),
              ),
              // Ikon Kamera jika tidak sedang upload
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
          // Teks Edit Profile Picture atau sedang upload
          Text(
            isUploading ? 'Uploading...' : 'Edit Profile Picture',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(String? profileImageUrl) {
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

      // Update the BLoC state dengan URL gambar baru
      context.read<UserBloc>().add(
            UpdateUserFieldEvent('profile_image', newProfileImageUrl),
          );

      // Notifikasi ke parent widget tentang gambar baru
      widget.onImagePicked(newProfileImageUrl);

      // Menampilkan snackbar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      // Menampilkan error jika gagal
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
