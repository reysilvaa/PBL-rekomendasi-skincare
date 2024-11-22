import 'package:flutter/material.dart';
import '../../model/recommendation.dart'; // Import your recommendation model

class ProductRecommendationSection extends StatelessWidget {
  final Recommendation recommendation;

  const ProductRecommendationSection({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    // Debugging: print the products length
    print(
        'Number of products: ${recommendation.skinCondition.products.length}');

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
                  // Loop through each product in the list
                  for (var product in recommendation.skinCondition.products)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                              product.productImage,
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
                                  product.productName,
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
                                        color: index < product.rating
                                            ? Colors.amber
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.description,
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
            ),
          // Show message if no products are found
          if (recommendation.skinCondition.products.isEmpty)
            const Text(
              'No products available for this skin condition.',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
