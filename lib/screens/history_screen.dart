import 'package:flutter/material.dart';
import '../model/history_item.dart';
import '../widgets/history/history_card.dart';
import '../widgets/history/history_header.dart';
import '../screens/history/recommendation_screen.dart'; // Import your Recommendation screen

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HistoryItem> historyItems = [
      HistoryItem(
        date: "30, Okt 2024",
        title: "Kondisi Kulit",
        subtitle: "berjerawat parah",
        description: "Lorem ipsum dolor sit amet",
        imagePath: "assets/profile_image.jpg",
      ),
      HistoryItem(
        date: "27, Okt 2024",
        title: "Kondisi Kulit",
        subtitle: "berjerawat parah",
        description: "Lorem ipsum dolor sit amet",
        imagePath: "assets/profile_image.jpg",
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          const HistoryHeader(), // Using the separated header widget
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the Recommendation screen when tapped
                    Navigator.pushNamed(
                      context,
                      '/history/recommendation', // Navigate to RecommendationScreen
                    );
                  },
                  child: HistoryCard(
                    historyItem: historyItems[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
