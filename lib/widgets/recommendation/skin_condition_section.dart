import 'package:deteksi_jerawat/model/recommendation.dart';
import 'package:deteksi_jerawat/model/treatments.dart';
import 'package:flutter/material.dart';

class SkinConditionSection extends StatelessWidget {
  final Recommendation recommendation;
  final Treatments? treatments;

  const SkinConditionSection(
      {super.key, required this.recommendation, this.treatments});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blueGrey.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              'Kondisi Kulit',
              Icons.health_and_safety_outlined,
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              recommendation.skinCondition.conditionName.isNotEmpty
                  ? recommendation.skinCondition.conditionName
                  : 'Nama Kondisi Tidak Tersedia',
              Icons.warning_amber_rounded,
              Colors.orange.shade200,
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(
              'Solusi Treatment',
              Icons.medical_services_outlined,
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              recommendation
                      .skinCondition.treatments.deskripsi_treatment.isNotEmpty
                  ? recommendation.skinCondition.treatments.deskripsi_treatment
                  : 'Treatment Tidak Tersedia',
              Icons.healing_outlined,
              Colors.green.shade200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blueGrey.shade700,
          size: 24,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey.shade900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String text, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
