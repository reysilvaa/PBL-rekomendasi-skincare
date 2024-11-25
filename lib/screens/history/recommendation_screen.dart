import 'package:deteksi_jerawat/blocs/history/history_event.dart';
import 'package:deteksi_jerawat/blocs/history/history_state.dart';
import 'package:deteksi_jerawat/model/history.dart';
import 'package:deteksi_jerawat/model/recommendation.dart';
import 'package:deteksi_jerawat/model/treatments.dart';
import 'package:deteksi_jerawat/widgets/recommendation/recommendation_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/history/history_bloc.dart';
import '../../services/history-info.dart';
import '../../widgets/recommendation/product_recommendation_section.dart';
import '../../widgets/recommendation/image_section.dart';
import '../../widgets/recommendation/skin_condition_section.dart';
import '../../screens/history/checkout_screen.dart';

class RecommendationScreen extends StatefulWidget {
  final History history;

  const RecommendationScreen({super.key, required this.history});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _selectedProductIndex = 0;

  @override
  Widget build(BuildContext context) {
    final recommendation = widget.history.recommendation;
    final detectionDate = widget.history.detectionDate ?? DateTime.now();
    final gambarScan = widget.history.gambarScan;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(
              history: widget.history,
              detectionDate: detectionDate,
            ),
            ImageSection(gambarScan: gambarScan),
            SkinConditionSection(
              recommendation: recommendation,
              treatments: recommendation.skinCondition.treatments,
            ),
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
