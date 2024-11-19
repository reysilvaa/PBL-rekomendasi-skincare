import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../widgets/camera/bottom_control.dart';
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
  final ValueNotifier<bool> _isCameraInitialized = ValueNotifier(false);
  int _currentCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[_currentCameraIndex],
          ResolutionPreset.medium,
        );

        await _controller!.initialize();

        if (!mounted) return; // Check if widget is still mounted

        _isCameraInitialized.value =
            true; // Notify listeners about camera initialization
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _onClose() {
    _disposeCamera();
    Navigator.pop(context); // Return to the previous page
  }

  void _onFlipCamera() {
    _disposeCamera(); // Dispose the current camera controller before switching
    _currentCameraIndex = _currentCameraIndex == 0 ? 1 : 0;
    _initializeCamera(); // Reinitialize the camera with the new index
  }

  Future<void> _onCapture() async {
    if (_controller == null || !_isCameraInitialized.value) return;
    try {
      final image = await _controller!.takePicture();
      print('Captured image path: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  void _disposeCamera() {
    _controller?.dispose(); // Dispose the camera controller
    _controller = null; // Clear the controller reference
    _isCameraInitialized.value = false; // Update the state
  }

  @override
  void dispose() {
    _disposeCamera(); // Dispose of the camera when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _isCameraInitialized,
              builder: (context, isInitialized, child) {
                if (isInitialized && _controller != null) {
                  return CameraPreviewWidget(
                    controller: _controller!,
                    onFlipCamera: _onFlipCamera,
                    onCapture: _onCapture,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            TopBar(onClose: _onClose), // Close button
            const CenterFrame(),
            const InstructionText(),
            BottomControl(
              onFlipCamera: _onFlipCamera,
              onCapture: _onCapture,
              onImageSelected: (String) {},
            ),
          ],
        ),
      ),
    );
  }
}
