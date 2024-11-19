import 'package:deteksi_jerawat/blocs/history/history_event.dart';
import 'package:deteksi_jerawat/blocs/history/history_state.dart';
import 'package:deteksi_jerawat/model/recommendation.dart';
import 'package:deteksi_jerawat/model/skincondition.dart';
import 'package:deteksi_jerawat/widgets/recommendation/recommendation_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/history/history_bloc.dart'; // Import HistoryBloc
import '../../services/history-info.dart'; // Import the HistoryService
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
      )..add(FetchHistories()), // Fetch histories on screen load
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryError) {
              return Center(child: Text(state.message));
            } else if (state is HistoryLoaded) {
              // Ensure that the history exists and is not empty
              final history =
                  state.histories.isNotEmpty ? state.histories[0] : null;

              if (history != null) {
                final detectionDate = history.detectionDate;
                final gambarScan = history.gambarScan;
                final recommendation = history.recommendation ??
                    Recommendation.empty(); // Fallback to empty recommendation

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pass detectionDate to HeaderSection
                      HeaderSection(
                        detectionDate: detectionDate ??
                            DateTime.now(), // Fallback to current date
                      ),

                      // Pass gambarScan to ImageSection
                      ImageSection(gambarScan: gambarScan ?? "Kosong"),

                      // Pass non-null recommendation to SkinConditionSection
                      SkinConditionSection(
                        recommendation: history.recommendation ??
                            Recommendation
                                .empty(), // Provide a fallback Recommendation if null
                      ),

                      ProductRecommendationSection(
                        recommendation:
                            recommendation, // Passing the non-null recommendation
                      ),
                      // BuyButton leading to checkout screen
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
                // Handle case where no history is available
                return const Center(child: Text('No history available.'));
              }
            } else {
              return const SizedBox(); // Default empty state
            }
          },
        ),
      ),
    );
  }
}
