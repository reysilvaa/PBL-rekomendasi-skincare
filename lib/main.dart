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
