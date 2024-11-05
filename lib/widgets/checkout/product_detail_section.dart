// lib/widgets/checkout/product_detail_section.dart
import 'package:flutter/material.dart';

class ProductDetailSection extends StatelessWidget {
  const ProductDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 9.0),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/produk/skintific.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skintific 2% Salicylic Acid Anti Acne Serum 20ml',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Rp50.000',
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('4.3', style: TextStyle(color: Colors.amber)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
