import 'package:deteksi_jerawat/widgets/card/error-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deteksi_jerawat/blocs/history/history_bloc.dart';
import 'package:deteksi_jerawat/blocs/history/history_event.dart';
import 'package:deteksi_jerawat/blocs/history/history_state.dart';
import 'package:deteksi_jerawat/widgets/history/history_card.dart';
import 'package:deteksi_jerawat/widgets/history/history_header.dart';
import 'package:deteksi_jerawat/services/history-info.dart'; // Make sure to import the service

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HistoryHeader(), // Header widget
          Expanded(
            child: BlocProvider(
              create: (context) => HistoryBloc(historyService: HistoryService())
                ..add(FetchHistories()), // Provide the service
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HistoryError) {
                    // Show the ErrorCard widget for errors
                    return ErrorCard(message: state.message);
                  } else if (state is HistoryLoaded) {
                    final historyItems = state.histories;
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: historyItems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the details page on item tap
                            Navigator.pushNamed(
                              context,
                              '/history/rekomendasi', // Make sure this route is set up
                            );
                          },
                          child: HistoryCard(
                            historyItem:
                                historyItems[index], // Passing the history data
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
