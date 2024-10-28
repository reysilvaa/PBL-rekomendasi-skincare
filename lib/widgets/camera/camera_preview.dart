import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './bottom_control.dart'; // Import the BottomControlBar

class CameraPreviewWidget extends StatelessWidget {
  final CameraController controller;
  final VoidCallback onFlipCamera; // Callback to flip the camera
  final VoidCallback onCapture; // Callback to capture an image

  const CameraPreviewWidget({
    Key? key,
    required this.controller,
    required this.onFlipCamera,
    required this.onCapture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-Screen Camera Preview
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black, // Background color while loading
            ),
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller), // Camera preview
            ),
          ),
          // Gradient overlay for better visibility of controls
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Instructions or overlays
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Text(
              'Align your face within the frame',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Bottom Control Bar
          Positioned(
            bottom: 20, // Positioning for the bottom control bar
            left: 0,
            right: 0,
            child: BottomControl(
              onFlipCamera: onFlipCamera,
              onCapture: onCapture,
            ),
          ),
        ],
      ),
    );
  }
}
