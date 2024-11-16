import 'package:deteksi_jerawat/model/skincondition.dart';
import 'package:flutter/material.dart';

class SkinConditionSection extends StatelessWidget {
  final SkinCondition
      skinCondition; // Accept the SkinCondition object as a parameter

  const SkinConditionSection({super.key, required this.skinCondition});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kondisi Kulit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            skinCondition.conditionName ??
                'Nama Kondisi Tidak Tersedia', // Fallback if null
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16), // Adding spacing
          const Text(
            'Solusi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            skinCondition.description ??
                'Deskripsi Tidak Tersedia', // Fallback if null
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
