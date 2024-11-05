// lib/widgets/recommendation/buy_button.dart
import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BuyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Panggil onPressed saat tombol ditekan
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey),
          ),
        ),
        child: const Center(
          child: Text(
            'Click to Buy',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
