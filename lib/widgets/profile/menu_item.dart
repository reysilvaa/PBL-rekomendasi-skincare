import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  final IconData? icon;

  const MenuItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.isLogout = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isLogout
              ? LinearGradient(
                  colors: [Colors.red.shade100, Colors.red.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: icon != null
              ? Icon(
                  icon,
                  color: isLogout ? Colors.red : Colors.blue.shade700,
                )
              : null,
          title: Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red.shade700 : Colors.blue.shade900,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            isLogout ? Icons.exit_to_app : Icons.arrow_forward_ios,
            color: isLogout ? Colors.red : Colors.blue.shade700,
            size: 18,
          ),
        ),
      ),
    );
  }
}
