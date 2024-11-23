import 'package:deteksi_jerawat/blocs/history/history_event.dart';
import 'package:deteksi_jerawat/blocs/history/history_state.dart';
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
  const RecommendationScreen({super.key});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int _selectedProductIndex = 0; // Index produk yang dipilih dari carousel

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(
        historyService: HistoryService(),
      )..add(FetchHistories()),
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryError) {
              return Center(child: Text(state.message));
            } else if (state is HistoryLoaded) {
              final history =
                  state.histories.isNotEmpty ? state.histories[0] : null;

              if (history != null) {
                final detectionDate = history.detectionDate ?? DateTime.now();
                final gambarScan = history.gambarScan;
                final recommendation = history.recommendation;
                final products = recommendation.skinCondition?.products ?? [];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      HeaderSection(
                        history: history,
                        detectionDate: detectionDate,
                      ),

                      // Image Section
                      ImageSection(gambarScan: gambarScan),

                      // Skin Condition Section
                      SkinConditionSection(
                        recommendation: recommendation,
                        treatments: recommendation.skinCondition.treatments,
                      ),

                      // Product Recommendations Section
                      ProductRecommendationSection(
                        recommendation: recommendation,
                        onProductChanged: (index) {
                          setState(() {
                            _selectedProductIndex = index; // Update index
                          });
                        },
                      ),

                      // Checkout Button
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No history available.'));
              }
            } else {
              return const SizedBox(); // Empty state
            }
          },
        ),
      ),
    );
  }
}
