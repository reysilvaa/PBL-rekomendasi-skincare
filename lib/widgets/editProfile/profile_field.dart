import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged; // Add onChanged parameter

  const ProfileField({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged, // Include onChanged as a required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          onChanged: onChanged, // Use onChanged to capture text changes
          decoration: InputDecoration(
            hintText: value,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
