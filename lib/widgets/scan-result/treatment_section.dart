// lib/widgets/scan_result/treatment_section.dart
import 'package:deteksi_jerawat/model/scan.dart';
import 'package:flutter/material.dart';

class TreatmentSection extends StatelessWidget {
  final Treatment treatment;
  static const Color primaryColor = Color(0xFF0046BE);

  const TreatmentSection({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    Icon(Icons.medical_services_outlined, color: primaryColor),
              ),
              const SizedBox(width: 12),
              const Text(
                'Recommended Treatment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            treatment.deskripsiTreatment,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
