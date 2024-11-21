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
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Circular profile placeholder
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300], // Placeholder background color
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                // Camera icon button overlay
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        final token = await Auth().getAccessToken();
                        if (token == null) {
                          throw Exception('No access token found');
                        }

                        // Call image picker and upload
                        String newProfileImageUrl =
                            await ImageUploadService().pickImageAndUpload(token);

                        // Notify the parent widget about the new image URL
                        onImagePicked(newProfileImageUrl);

                        print('Image uploaded successfully: $newProfileImageUrl');
                      } catch (e) {
                        print("Image upload failed: $e");
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,  
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Edit Profile Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
