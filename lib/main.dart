import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/screens/home_screen.dart';
import 'package:deteksi_jerawat/screens/login_screen.dart';
import 'package:deteksi_jerawat/screens/history/recommendation_screen.dart';
import 'package:deteksi_jerawat/screens/camera_screen.dart';
import 'package:deteksi_jerawat/screens/history_screen.dart';
import 'package:deteksi_jerawat/screens/profile_screen.dart';
import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import '/services/user-info.dart';
import '/services/auth.dart';
import 'splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  // Function to request necessary permissions
  Future<void> _requestPermissions() async {
    // Request camera permission
    PermissionStatus status = await Permission.camera.request();
    if (status.isDenied) {
      // Handle the case when the user denies the permission
      _showPermissionDeniedDialog();
    } else if (status.isPermanentlyDenied) {
      // Handle the case when the user permanently denies the permission
      openAppSettings(); // This opens the app settings to let the user enable it
    } 
    // Add more permissions if needed, e.g., storage, location, etc.
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content:
              const Text('Camera permission is required to use this feature.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserInfoService>(
          create: (context) => UserInfoService(),
        ),
        RepositoryProvider<Auth>(
          create: (context) => Auth(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              userInfoService: context.read<UserInfoService>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Deteksi Jerawat',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF1a5fab),
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/scan': (context) => const CameraScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/history': (context) => const HistoryScreen(),
            '/history/rekomendasi': (context) => const RecommendationScreen(),
          },
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Page not found')),
            ),
          ),
        ),
      ),
    );
  }
}
