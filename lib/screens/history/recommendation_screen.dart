import 'package:deteksi_jerawat/model/history.dart';
import 'package:deteksi_jerawat/widgets/recommendation/recommendation_header.dart';
import 'package:flutter/material.dart';
import '../../widgets/recommendation/product_recommendation_section.dart';
import '../../widgets/recommendation/image_section.dart';
import '../../widgets/recommendation/skin_condition_section.dart';

class RecommendationScreen extends StatefulWidget {
  final History history;

  const RecommendationScreen({super.key, required this.history});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  // ignore: unused_field
  int _selectedProductIndex = 0;

  @override
  Widget build(BuildContext context) {
    final recommendation = widget.history.recommendation;
    final detectionDate = widget.history.detectionDate;
    final gambarScan = widget.history.gambarScan;
    final gambarScanPredicted = widget
        .history.gambarScanPredicted; // Ambil gambarScanPredicted dari History

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            HeaderSection(
              history: widget.history,
              detectionDate: detectionDate,
            ),
            // Gambar Scan dan Predicted
            ImageSection(
              gambarScan: gambarScan,
              gambarScanPredicted:
                  gambarScanPredicted, // Mengirim gambarScanPredicted
            ),
            // Kondisi kulit dan treatment
            SkinConditionSection(
              recommendation: recommendation,
              treatments: recommendation.skinCondition.treatments,
            ),
            // Rekomendasi produk
            ProductRecommendationSection(
              recommendation: recommendation,
              onProductChanged: (index) {
                setState(() {
                  _selectedProductIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
