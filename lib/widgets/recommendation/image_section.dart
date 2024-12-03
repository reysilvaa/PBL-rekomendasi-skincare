import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  final String gambarScan; // URL gambar pertama
  final String gambarScanPredicted; // URL gambar kedua

  const ImageSection({
    super.key,
    required this.gambarScan,
    required this.gambarScanPredicted,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar pertama (gambarScan)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: gambarScan,
                width: 149,
                height: 155,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(), // Placeholder saat gambar dimuat
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error), // Jika gagal memuat gambar
              ),
            ),
            const SizedBox(height: 16), // Spasi antara gambar pertama dan kedua

            // Gambar kedua (gambarScanPredicted)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: gambarScanPredicted,
                width: 149,
                height: 155,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(), // Placeholder saat gambar dimuat
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error), // Jika gagal memuat gambar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
