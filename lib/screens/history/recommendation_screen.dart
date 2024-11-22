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
                final detectionDate = history.detectionDate is DateTime
                    ? history.detectionDate
                    : DateTime.now();

                final gambarScan = history.gambarScan;

                // Ensure correct Recommendation and Treatments handling
                final recommendation = history.recommendation;
                final treatments = recommendation.skinCondition.treatments; // Correct assignment here

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderSection(detectionDate: detectionDate),
                      ImageSection(gambarScan: gambarScan),
                      SkinConditionSection(
                        recommendation: recommendation,
                        treatments: treatments, // Passing treatments
                      ),
                      ProductRecommendationSection(
                        recommendation: recommendation,
                      ),
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
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
