import 'package:flutter/material.dart';
import '../../widgets/recommendation/recommendation_header.dart';
import '../../widgets/recommendation/product_recommendation_section.dart';
import '../../widgets/recommendation/profile_section.dart';
import '../../widgets/recommendation/skin_condition_section.dart';
import '../../widgets/bottom_navigation.dart'; // Ensure to import your BottomNavigation

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

    // if (index == 0) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => MainScreen()));
    // }
    // if (index == 1) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => MainScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderSection(date: '30, Okt 2024'), // Use the new header
            ProfileSection(),
            SkinConditionSection(),
            ProductRecommendationSection(),
          ],
        ),
      ),
    );
  }
}
