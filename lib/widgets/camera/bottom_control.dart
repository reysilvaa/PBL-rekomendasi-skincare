import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package

class BottomControl extends StatelessWidget {
  final VoidCallback onFlipCamera; // Callback to flip the camera
  final VoidCallback onCapture; // Callback to capture an image
  final Function(String) onImageSelected; // Callback to handle selected image

  const BottomControl({
    super.key,
    required this.onFlipCamera,
    required this.onCapture,
    required this.onImageSelected, // Accept the callback for image selection
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20, // Positioning for the bottom control bar
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
              onPressed: onFlipCamera, // Use the passed callback
            ),
            GestureDetector(
              onTap: onCapture, // Use the passed callback
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.blue, size: 30),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.image, color: Colors.white),
              onPressed: () async {
                try {
                  // Open the gallery to pick an image
                  final picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);

                  // Check if the user selected an image
                  if (image != null) {
                    // Call the callback and pass the selected image path
                    onImageSelected(image.path);
                  } else {
                    print("No image selected");
                  }
                } catch (e) {
                  print("Error picking image: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
