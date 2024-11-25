// history_screen.dart
import 'package:deteksi_jerawat/widgets/card/error-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/blocs/history/history_bloc.dart';
import 'package:deteksi_jerawat/blocs/history/history_event.dart';
import 'package:deteksi_jerawat/blocs/history/history_state.dart';
import 'package:deteksi_jerawat/widgets/history/history_card.dart';
import 'package:deteksi_jerawat/widgets/history/history_header.dart';
import 'package:deteksi_jerawat/services/history-info.dart';
import 'package:deteksi_jerawat/screens/history/recommendation_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HistoryHeader(),
          Expanded(
            child: BlocProvider(
              create: (context) => HistoryBloc(historyService: HistoryService())
                ..add(FetchHistories()),
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HistoryError) {
                    return ErrorCard(message: state.message);
                  } else if (state is HistoryLoaded) {
                    final historyItems = state.histories;
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: historyItems.length,
                      itemBuilder: (context, index) {
                        final historyItem = historyItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecommendationScreen(
                                  history: historyItem,
                                ),
                              ),
                            );
                          },
                          child: HistoryCard(
                            historyItem: historyItem,
                            recommendation: historyItem.recommendation,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Tidak ada riwayat.'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
