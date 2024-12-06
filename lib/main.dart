import 'package:deteksi_jerawat/blocs/scan/scan_bloc.dart';
import 'package:deteksi_jerawat/services/scan-post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/screens/home_screen.dart';
import 'package:deteksi_jerawat/screens/login_screen.dart';
import 'package:deteksi_jerawat/screens/history_screen.dart';
import 'package:deteksi_jerawat/screens/profile_screen.dart';
import 'package:deteksi_jerawat/blocs/user/user_bloc.dart';
import '/services/user-info.dart';
import '/services/auth.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => UserInfoService()),
        RepositoryProvider(create: (_) => Auth()),
        Provider(create: (_) => ScanService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ScanBloc(
              scanService: context.read<ScanService>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userInfoService: context.read<UserInfoService>(),
              authService: Auth(),
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
            '/login': (context) => const LoginScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/history': (context) => const HistoryScreen(),
          },
        ),
      ),
    );
  }
}
