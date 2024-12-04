// lib/widgets/scan_result/condition_details_section.dart
import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/model/scan.dart';

class ConditionDetailsSection extends StatelessWidget {
  final Scan scan;
  static const Color primaryColor = Color(0xFF0046BE);

  const ConditionDetailsSection({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scan.data.condition.conditionName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          scan.data.condition.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildConfidenceCard(),
      ],
    );
  }

  Widget _buildConfidenceCard() {
    final confidence = (scan.data.prediction.confidence * 100).toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.analytics_outlined, color: primaryColor),
          const SizedBox(width: 12),
          Text(
            "Prediction Confidence: $confidence%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}