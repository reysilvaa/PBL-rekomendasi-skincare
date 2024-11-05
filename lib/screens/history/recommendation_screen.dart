import 'package:flutter/material.dart';
import '../../widgets/recommendation/recommendation_header.dart';
import '../../widgets/recommendation/product_recommendation_section.dart';
import '../../widgets/recommendation/profile_section.dart';
import '../../widgets/recommendation/skin_condition_section.dart';
import '../../widgets/recommendation/buy_button.dart';
import '../../screens/history/checkout_screen.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _selectedIndex = 0; // Initial index for HomeScreen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection(date: '30, Okt 2024'),
            const ProfileSection(),
            const SkinConditionSection(),
            const ProductRecommendationSection(),

            // Memanggil BuyButton di bawah ProductRecommendationSection
            BuyButton(
              onPressed: () {
                // Navigasi ke CheckoutScreen saat tombol BuyButton ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
