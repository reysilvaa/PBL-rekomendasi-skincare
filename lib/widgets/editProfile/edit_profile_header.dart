import 'package:deteksi_jerawat/services/pick_image_and_upload.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';

class EditProfileHeader extends StatelessWidget {
  final Function(String) onImagePicked; // Callback for passing the image URL

  const EditProfileHeader({
    Key? key,
    required this.onImagePicked, // Accept the callback as a parameter
  }) : super(key: key);

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
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () async {
                try {
                  // Get the token from the Auth service
                  final token = await Auth().getAccessToken();
                  if (token == null) {
                    throw Exception('No access token found');
                  }

                  // Call the method to pick and upload the image with the token
                  String newProfileImageUrl =
                      await ImageUploadService().pickImageAndUpload(token);

                  // Notify the parent widget about the new image URL
                  onImagePicked(newProfileImageUrl);

                  print('Gambar berhasil diunggah: $newProfileImageUrl');
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
