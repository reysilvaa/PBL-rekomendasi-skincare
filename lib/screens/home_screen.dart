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
        child: Container(
          color: Colors.grey[50], // Background halus
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: const UserHeader(), // Header di paling atas
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GreetingCard(), // Kartu sapaan
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
