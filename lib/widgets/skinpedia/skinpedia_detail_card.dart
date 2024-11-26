import 'package:deteksi_jerawat/model/skinpedia.dart';
import 'package:flutter/material.dart';

class SkinpediaDetailModal extends StatelessWidget {
  final Skinpedia skinpedia;

  const SkinpediaDetailModal({
    Key? key,
    required this.skinpedia,
  }) : super(key: key);

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
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // Lebih melengkung untuk kesan modern
          ),
          padding: const EdgeInsets.only(top: 16),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (skinpedia.image.isNotEmpty)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Image.network(
                                skinpedia.image,
                                width: double.infinity,
                                height: 280, // Menambah sedikit tinggi gambar untuk tampilan lebih menarik
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 280,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported, size: 70), // Ukuran ikon diperbesar
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                              color: Colors.white,
                              iconSize: 30,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.6),
                                shape: CircleBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.all(24.0), // Padding lebih besar untuk ruang yang lebih lapang
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skinpedia.title,
                            style: const TextStyle(
                              fontSize: 26, // Ukuran font judul lebih besar
                              fontWeight: FontWeight.bold, // Gunakan font bold untuk kontras lebih kuat
                              color: Colors.black87, // Warna teks lebih gelap untuk visibilitas
                            ),
                          ),
                          const SizedBox(height: 20), // Lebih banyak ruang antar elemen
                          Text(
                            skinpedia.description,
                            style: TextStyle(
                              fontSize: 18, // Ukuran font deskripsi lebih besar
                              color: Colors.grey[700],
                              height: 1.7, // Memberikan sedikit jarak antar baris
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
        );
      },
    );
  }
}
