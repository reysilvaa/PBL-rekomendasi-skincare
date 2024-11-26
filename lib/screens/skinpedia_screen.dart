import 'package:deteksi_jerawat/model/skinpedia.dart';
import 'package:deteksi_jerawat/services/skinpedia-info.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/loading_state.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/skinpedia_card.dart';
import 'package:deteksi_jerawat/widgets/skinpedia/skinpedia_detail_card.dart';
import 'package:flutter/material.dart';

class SkinpediaScreen extends StatefulWidget {
  const SkinpediaScreen({Key? key}) : super(key: key);

  @override
  _SkinpediaScreenState createState() => _SkinpediaScreenState();
}

class _SkinpediaScreenState extends State<SkinpediaScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Skinpedia>> _skinpediaFuture;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _skinpediaFuture = SkinpediaService().fetchSkinpedia();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward(); // Memulai animasi saat screen ditampilkan
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            floating: true,
            pinned: true,
            elevation: 10, // Efek bayangan lebih halus
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Skinpedia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20, // Ukuran font yang lebih besar
                ),
              ),
              centerTitle: true,
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2563EB),
                      Color(0xFF3B82F6),
                      Color(0xFF60A5FA),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            sliver: FutureBuilder<List<Skinpedia>>(
              future: _skinpediaFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(child: LoadingState());
                }

                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No data available')),
                  );
                }

                final List<Skinpedia> skinpediaList = snapshot.data!;

                return SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: skinpediaList.length,
                  itemBuilder: (context, index) {
                    final skinpedia = skinpediaList[index];
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.5),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: Interval(
                                (index / skinpediaList.length),
                                1.0,
                                curve: Curves.easeOut,
                              ),
                            ),
                          ),
                          child: child,
                        );
                      },
                      child: SkinpediaCard(
                        skinpedia: skinpedia,
                        onTap: () => _showDetailModal(context, skinpedia),
                      ),
                    );
                  },
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
