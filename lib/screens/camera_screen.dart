import 'package:deteksi_jerawat/blocs/scan/scan_bloc.dart';
import 'package:deteksi_jerawat/blocs/scan/scan_event.dart';
import 'package:deteksi_jerawat/blocs/scan/scan_state.dart';
import 'package:deteksi_jerawat/screens/scan_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/camera/bottom_control.dart';
import '../widgets/camera/camera_preview.dart';
import '../widgets/camera/center_frame.dart';
import '../widgets/camera/instruction_text.dart';
import '../widgets/camera/top_bar.dart';
import 'dart:io';

class ConfirmationControls extends StatelessWidget {
  final File imageFile;
  final VoidCallback onConfirm;
  final VoidCallback onRetake;

  const ConfirmationControls({
    Key? key,
    required this.imageFile,
    required this.onConfirm,
    required this.onRetake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: Image.file(imageFile, fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.check_circle,
                    color: Colors.green, size: 50),
                onPressed: onConfirm,
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red, size: 50),
                onPressed: onRetake,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final String token;

  const CameraScreen({
    super.key,
    required this.token,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  final ValueNotifier<bool> _isCameraInitialized = ValueNotifier(false);
  int _currentCameraIndex = 0;
  bool _isLoading = false;
  File? _capturedImage;

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
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _onCapture() async {
    if (_controller == null || !_isCameraInitialized.value) return;

    try {
      final image = await _controller!.takePicture();
      setState(() {
        _capturedImage = File(image.path);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _onConfirm() {
    if (_capturedImage != null) {
      context
          .read<ScanBloc>()
          .add(AnalyzeImageEvent(_capturedImage!, widget.token));
      setState(() {
        _capturedImage = null;
      });
    }
  }

  void _onRetake() {
    setState(() {
      _capturedImage = null;
    });
  }

  Future<void> _disposeCamera() async {
    await _controller?.dispose();
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _isCameraInitialized,
            builder: (context, isInitialized, child) {
              if (isInitialized && _controller != null) {
                return SizedBox.expand(
                  child: CameraPreviewWidget(
                    controller: _controller!,
                    onFlipCamera: () async {
                      await _disposeCamera();
                      _currentCameraIndex = _currentCameraIndex == 0 ? 1 : 0;
                      await _initializeCamera();
                    },
                    onCapture: _onCapture,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: TopBar(onClose: () => Navigator.pop(context)),
                ),
                const Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  height: 200,
                  child: CenterFrame(),
                ),
                const Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  height: 40,
                  child: InstructionText(),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: BottomControl(
                    onFlipCamera: () async {
                      await _disposeCamera();
                      _currentCameraIndex = _currentCameraIndex == 0 ? 1 : 0;
                      await _initializeCamera();
                    },
                    onCapture: _onCapture,
                    onImageSelected: (String path) {
                      final File imageFile = File(path);
                      context
                          .read<ScanBloc>()
                          .add(AnalyzeImageEvent(imageFile, widget.token));
                    },
                  ),
                )
              ],
            ),
          ),
          BlocListener<ScanBloc, ScanState>(
            listener: (context, state) {
              if (state is ScanLoading) {
                setState(() => _isLoading = true);
              } else {
                setState(() => _isLoading = false);

                if (state is ScanSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanResultScreen(scan: state.scan),
                    ),
                  );
                } else if (state is ScanError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              }
            },
            child: const SizedBox.shrink(),
          ),
          if (_capturedImage != null)
            Positioned.fill(
              child: ConfirmationControls(
                imageFile: _capturedImage!,
                onConfirm: _onConfirm,
                onRetake: _onRetake,
              ),
            ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/analyze.gif', width: 200),
                      const SizedBox(height: 20),
                      const Text(
                        'Analyzing...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
