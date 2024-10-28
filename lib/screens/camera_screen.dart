import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../widgets/camera/bottom_control.dart'; // Update the import
import '../widgets/camera/camera_preview.dart';
import '../widgets/camera/center_frame.dart';
import '../widgets/camera/instruction_text.dart';
import '../widgets/camera/top_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  bool _isCameraInitialized = false;
  int _currentCameraIndex = 0; // Track the current camera index

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    // Check if cameras are available
    if (cameras.isNotEmpty) {
      _controller = CameraController(
        cameras[_currentCameraIndex], // Use the current camera index
        ResolutionPreset.medium,
      );

      await _controller!.initialize();
      if (!mounted) return;
      setState(() => _isCameraInitialized = true);
    } else {
      // Handle the case where no camera is available
      print('No cameras available');
    }
  }

  void _onClose() {
    Navigator.pop(context);
  }

  void _onFlipCamera() {
    // Flip the camera by changing the camera index
    setState(() {
      _currentCameraIndex =
          _currentCameraIndex == 0 ? 1 : 0; // Toggle between 0 and 1
      _initializeCamera(); // Re-initialize the camera with the new index
    });
  }

  Future<void> _onCapture() async {
    try {
      final image = await _controller!.takePicture();
      // Save or use the captured image
      print('Captured image path: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            if (_isCameraInitialized)
              CameraPreviewWidget(
                controller: _controller!,
                onFlipCamera: _onFlipCamera, // Pass the callback
                onCapture: _onCapture, // Pass the callback
              ),

            // Top Bar
            TopBar(onClose: _onClose),

            // Center Frame Guide
            const CenterFrame(),

            // Instruction Text
            const InstructionText(),

            // Bottom Control Bar
            BottomControl(
              onFlipCamera: _onFlipCamera,
              onCapture: _onCapture,
            ),
          ],
        ),
      ),
    );
  }
}
