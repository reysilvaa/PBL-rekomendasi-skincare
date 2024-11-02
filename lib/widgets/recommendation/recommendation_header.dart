// lib/widgets/recommendation/header_section.dart
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String date;

  const HeaderSection({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF0D47A1),
      child: Center(
        child: Text(
          date,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
