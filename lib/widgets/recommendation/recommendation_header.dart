import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'back_button.dart';

class HeaderSection extends StatelessWidget {
  final DateTime detectionDate; // Receive DateTime here

  const HeaderSection({Key? key, required this.detectionDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date to display in the header
    final formattedDate = DateFormat('dd MMM yyyy').format(detectionDate);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF0D47A1),
      child: Row(
        children: [
          const BackButtonWidget(), // Menambahkan tombol kembali di sebelah kiri
          const SizedBox(width: 8), // Jarak antara tombol dan teks
          Expanded(
            child: Center(
              child: Text(
                formattedDate, // Display the formatted date
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
