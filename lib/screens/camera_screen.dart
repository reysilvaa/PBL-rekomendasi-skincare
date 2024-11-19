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

        if (!mounted) return;

        _isCameraInitialized.value = true;
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _onClose() {
    _disposeCamera();
    Navigator.pop(context);
  }

  void _onFlipCamera() {
    _disposeCamera();
    _currentCameraIndex = _currentCameraIndex == 0 ? 1 : 0;
    _initializeCamera();
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
    _controller?.dispose();
    _controller = null;
    _isCameraInitialized.value = false;
  }

  @override
  void dispose() {
    _disposeCamera();
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
            // TopBar at the top of the screen
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: TopBar(onClose: _onClose),
            ),
            // CenterFrame for face alignment
            const Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: CenterFrame(),
            ),
            // InstructionText on top of the camera preview
            const Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: InstructionText(),
            ),
            // Bottom control bar
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: BottomControl(
                onFlipCamera: _onFlipCamera,
                onCapture: _onCapture,
                onImageSelected: (String path) {
                  print('Image selected: $path');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
