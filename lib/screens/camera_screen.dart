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
  bool _isCameraInitialized = false;
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
        if (!mounted) return; // Pastikan widget masih terpasang

        setState(() {
          _isCameraInitialized = true;
        });
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _onClose() {
    _disposeCamera();
    Navigator.pop(context); // Kembali ke halaman sebelumnya
  }

  void _onFlipCamera() {
    _disposeCamera(); // Membuang controller kamera saat ini sebelum beralih
    setState(() {
      _currentCameraIndex = _currentCameraIndex == 0 ? 1 : 0;
      _initializeCamera(); // Menginisialisasi ulang kamera dengan indeks baru
    });
  }

  Future<void> _onCapture() async {
    if (_controller == null || !_isCameraInitialized)
      return; // Memastikan controller tidak null dan kamera terinisialisasi
    try {
      final image = await _controller!.takePicture();
      print('Captured image path: ${image.path}');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  void _disposeCamera() {
    _controller?.dispose(); // Membuang controller kamera
    _controller = null; // Menghapus referensi controller
    if (mounted) {
      setState(() {
        _isCameraInitialized = false; // Mengatur ulang status inisialisasi
      });
    }
  }

  @override
  void dispose() {
    _disposeCamera(); // Pastikan kamera dibuang ketika widget dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (_isCameraInitialized &&
                _controller != null) // Pastikan controller tidak null
              CameraPreviewWidget(
                controller: _controller!,
                onFlipCamera: _onFlipCamera,
                onCapture: _onCapture,
              ),
            TopBar(onClose: _onClose), // Tombol close
            const CenterFrame(),
            const InstructionText(),
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
