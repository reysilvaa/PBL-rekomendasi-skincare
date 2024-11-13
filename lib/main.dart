// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/widgets/bottom_navigation.dart';
import './screens/login_screen.dart';
import './screens/history/recommendation_screen.dart';
import 'screens/home_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';
import 'blocs/user/user_bloc.dart';
import '/services/user-info.dart';
import '/services/auth.dart'; // Import auth_service.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserInfoService>(
          create: (context) => UserInfoService(),
        ),
        RepositoryProvider<Auth>(
          // Menyediakan Auth sebagai repository
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
          // Tambahkan BLoC lainnya di sini
        ],
        child: MaterialApp(
          title: 'Deteksi Jerawat',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF1a5fab),
            scaffoldBackgroundColor: Colors.white,
          ),
          home: FutureBuilder<bool>(
            future: _checkLoginStatus(context), // Memanggil fungsi cek login
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              return snapshot.data == true ? MainScreen() : const LoginScreen();
            },
          ),
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

  Future<bool> _checkLoginStatus(BuildContext context) async {
    final auth = context.read<Auth>(); // Menggunakan Auth instance
    return await auth.isLoggedIn(); // Cek status login
  }
}
