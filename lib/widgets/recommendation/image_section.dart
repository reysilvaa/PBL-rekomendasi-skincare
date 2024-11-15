import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  final String gambarScan; // Accept image URL as a parameter

  const ImageSection({super.key, required this.gambarScan});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl:
                gambarScan, // Use CachedNetworkImage to load and cache the image
            width: 149,
            height: 155,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child:
                  CircularProgressIndicator(), // Placeholder while image loads
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error), // Error widget in case of failure
          ),
        ),
      ),
    );
  }
}
