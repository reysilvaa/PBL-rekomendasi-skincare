import 'package:flutter/material.dart';
import '../../model/recommendation.dart'; // Import your recommendation model

class ProductRecommendationSection extends StatelessWidget {
  final Recommendation recommendation;

  const ProductRecommendationSection({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rekomendasi Skincare',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Ensure we have products in the skin condition
          if (recommendation.skinCondition.products.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      recommendation.skinCondition.products[0].productImage,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation.skinCondition.products[0].productName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Add stars based on a dynamic rating
                            ...List.generate(
                              5, // Assume 5-star rating system
                              (index) => Icon(
                                Icons.star,
                                size: 16,
                                color: index <
                                        (recommendation.skinCondition
                                                .products[0].rating ??
                                            0)
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recommendation.skinCondition.products[0].description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
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
  }
}
