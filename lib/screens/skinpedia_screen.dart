import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/model/skinpedia.dart';
import 'package:deteksi_jerawat/services/skinpedia-info.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/loading_state.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/skinpedia_card.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/skinpedia_detail_card.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/skinpedia_header.dart'; // Impor widget header

class SkinpediaScreen extends StatefulWidget {
  const SkinpediaScreen({super.key});

  @override
  _SkinpediaScreenState createState() => _SkinpediaScreenState();
}

class _SkinpediaScreenState extends State<SkinpediaScreen> {
  late Future<List<Skinpedia>> _skinpediaFuture;

  @override
  void initState() {
    super.initState();
    _skinpediaFuture = SkinpediaService().fetchSkinpedia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          const SkinpediaHeader(), // Gunakan widget header di sini
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: FutureBuilder<List<Skinpedia>>(
              future: _skinpediaFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(child: LoadingState());
                }

                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final skinpedia = snapshot.data![index];
                      return SkinpediaCard(
                        skinpedia: skinpedia,
                        onTap: () => _showDetailModal(context, skinpedia),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailModal(BuildContext context, Skinpedia skinpedia) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SkinpediaDetailModal(skinpedia: skinpedia),
    );
  }
}
