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
import '../../widgets/recommendation/buy_button.dart';
import '../../screens/history/checkout_screen.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

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
                // Ensure correct DateTime conversion
                final detectionDate = history.detectionDate ?? DateTime.now();
                final gambarScan = history.gambarScan;
                final recommendation = history.recommendation;
                final treatments = recommendation.skinCondition?.treatments ??
                    []; // Safe handling of treatments

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      HeaderSection(
                        history: history, // Pass the whole history object
                        detectionDate:
                            history.detectionDate, // Pass detectionDate
                      ),
// Pass the whole history object
                      // Image Section
                      ImageSection(
                          gambarScan: gambarScan), // Pass only gambarScan
                      // Skin Condition Section
                      SkinConditionSection(
                        recommendation: recommendation,
                        treatments:
                            recommendation.condition.treatments, // Passing treatments to the section
                      ),
                      // Product Recommendations Section
                      ProductRecommendationSection(
                        recommendation: recommendation,
                      ),
                      // Buy Button
                      BuyButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No history available.'));
              }
            } else {
              return const SizedBox(); // If no state, show an empty widget
            }
          },
        ),
      ),
    );
  }
}
