import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/home/greeting_card.dart';
import '../widgets/home/brand_list.dart';
import '../widgets/home/product_list.dart';
import '../widgets/home/user_header.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      if (mounted) {
        context.read<UserBloc>().add(FetchUserEvent(token));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 40, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${state.message}', style: TextStyle(color: Colors.red, fontSize: 18)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _initializeUser,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is UserLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: UserHeader(user: state.user),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(top: 20)),
                    SliverToBoxAdapter(
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: GreetingCard(),
                        ),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(top: 20)),
                    SliverToBoxAdapter(
                      child: const SectionTitle(title: 'Brands'),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(top: 10)),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: const BrandList(),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(top: 20)),
                    SliverToBoxAdapter(
                      child: const SectionTitle(title: 'Products'),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(top: 10)),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: const ProductList(),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
