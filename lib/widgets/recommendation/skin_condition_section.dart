import 'package:deteksi_jerawat/model/recommendation.dart';
import 'package:deteksi_jerawat/model/skincondition.dart';
import 'package:deteksi_jerawat/model/treatments.dart';
import 'package:flutter/material.dart';

class SkinConditionSection extends StatelessWidget {
  final Recommendation recommendation;
  final Treatments? treatments; // Make treatments nullable

  const SkinConditionSection(
      {super.key, required this.recommendation, this.treatments});

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
            recommendation.skinCondition?.conditionName ??
                'Nama Kondisi Tidak Tersedia',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Solusi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            treatments?.deskripsi_treatment ??
                'Nama Treatment Tidak Tersedia', // Correctly handling null for treatments
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
