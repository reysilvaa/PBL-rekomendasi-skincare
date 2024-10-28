import 'package:flutter/material.dart';
import '../widgets/home/greeting_card.dart';
import '../widgets/home/brand_list.dart';
import '../widgets/home/product_list.dart';
import '../widgets/home/user_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const UserHeader(),
              // const CustomSearchBar(), // Uncomment if you need the search bar
              const SizedBox(height: 20),
              const GreetingCard(),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Brands'),
              const SizedBox(height: 10),
              const BrandList(),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Products'),
              const SizedBox(height: 10),
              const ProductList(),
            ],
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
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
