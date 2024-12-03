import 'package:deteksi_jerawat/model/skinpedia.dart';
import 'package:flutter/material.dart';

class SkinpediaDetailModal extends StatelessWidget {
  final Skinpedia skinpedia;

  const SkinpediaDetailModal({
    super.key,
    required this.skinpedia,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ClipRRect( // ClipRRect untuk memastikan gambar tidak keluar dari radius
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Column(
              children: [
                Padding( // Widget drag indicator dipindahkan ke dalam padding
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (skinpedia.image.isNotEmpty)
                              Stack(
                                children: [
                                  Hero( // Tambahkan Hero widget untuk animasi transisi
                                    tag: skinpedia.id, 
                                    child: Image.network(
                                      skinpedia.image,
                                      width: double.infinity,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    skinpedia.title,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    skinpedia.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 24), // Tambahkan spasi di bagian bawah
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}