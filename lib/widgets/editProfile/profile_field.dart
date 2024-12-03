import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged; // Add onChanged parameter

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged, // Include onChanged as a required parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.blueGrey[800], // Subtle but visible label color
            fontSize: 14,
            fontWeight: FontWeight.w600, // Slightly bold for better emphasis
          ),
        ),
        const SizedBox(height: 8), // Add some spacing for better readability
        TextField(
          onChanged: onChanged, // Use onChanged to capture text changes
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100], // Light background for the input
            hintText: "Enter your $label", // More meaningful placeholder
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), // Smooth rounded corners
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.blueAccent.shade100, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
