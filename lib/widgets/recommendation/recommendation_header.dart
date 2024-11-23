import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'back_button.dart';
import 'package:deteksi_jerawat/model/history.dart'; // Import the History model

class HeaderSection extends StatelessWidget {
  final History history; // Receive the entire History object

  // Constructor with a required parameter of History
  const HeaderSection({Key? key, required this.history, required DateTime detectionDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date to display in the header
    final formattedDate =
        DateFormat('dd MMM yyyy').format(history.detectionDate);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF0D47A1),
      child: Row(
        children: [
          const BackButtonWidget(), // Adding a back button on the left
          const SizedBox(width: 8), // Space between button and text
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
