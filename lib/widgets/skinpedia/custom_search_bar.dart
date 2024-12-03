import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // Increased height for better touch target
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Added vertical margin
      decoration: BoxDecoration(
        color: Colors.grey[200], // Softer background color
        borderRadius: BorderRadius.circular(24), // More pronounced rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 16), // Slightly larger font size
        decoration: InputDecoration(
          hintText: 'Search Skinpedia...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue[700], // More vibrant blue
            size: 24, // Larger icon
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, // Increased padding
            vertical: 12,
          ),
        ),
      ),
    );
  }
}