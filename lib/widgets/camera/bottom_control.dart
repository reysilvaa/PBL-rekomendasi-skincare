import 'package:flutter/material.dart';

class BottomControl extends StatelessWidget {
  final VoidCallback onFlipCamera; // Callback to flip the camera
  final VoidCallback onCapture; // Callback to capture an image

  const BottomControl({
    Key? key,
    required this.onFlipCamera,
    required this.onCapture,
  }) : super(key: key);

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
                decoration: BoxDecoration(
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
              onPressed: () {
                // Add logic to open image gallery
              },
            ),
          ],
        ),
      ),
    );
  }
}
