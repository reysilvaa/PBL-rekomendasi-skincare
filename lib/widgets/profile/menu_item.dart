import 'package:flutter/material.dart';

// menu_item.dart
class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const MenuItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black87,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
