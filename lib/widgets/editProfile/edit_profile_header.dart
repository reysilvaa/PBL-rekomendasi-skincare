import 'package:deteksi_jerawat/services/pick_image_and_upload.dart';
import 'package:deteksi_jerawat/services/user-info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';
import '../../blocs/user/user_state.dart';

class EditProfileHeader extends StatelessWidget {
  final Function(String newProfileImageUrl) onImagePicked;

  const EditProfileHeader({Key? key, required this.onImagePicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        width: double.infinity,
        color: const Color(0xFF0D47A1),
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                // Check if the state is UserLoaded and has a profile image
                if (state is UserLoaded) {
                  final user = state.user;

                  // Use UserInfoService to get the full image URL
                  final fullImageUrl = user.profileImage != null
                      ? UserInfoService().getFullImageUrl(user.profileImage!)
                      : null;

                  return CircleAvatar(
                    radius: 40,
                    backgroundImage: fullImageUrl != null
                        ? CachedNetworkImageProvider(
                            fullImageUrl) // Cache image if available
                        : const AssetImage('assets/profile/wajah.png')
                            as ImageProvider,
                  );
                }

                return const SizedBox
                    .shrink(); // Return empty widget if no user data
              },
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () async {
                try {
                  // Pick and upload an image, getting the new image URL
                  String newProfileImageUrl =
                      await pickImageAndUpload(); // Memanggil dari image_service.dart

                  // Use the callback function to pass the image URL
                  onImagePicked(newProfileImageUrl);
                } catch (e) {
                  print("Image upload failed: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
