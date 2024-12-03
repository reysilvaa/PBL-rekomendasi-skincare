import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  final IconData? icon;

  const MenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isLogout = false,
    this.icon,
  });

  // Dynamic icon mapping based on title
  IconData _getIconForTitle() {
    final lowercaseTitle = title.toLowerCase();
    if (lowercaseTitle.contains('saved')) return Icons.save_alt_rounded;
    if (lowercaseTitle.contains('profile')) return Icons.person_outline_rounded;
    if (lowercaseTitle.contains('setting')) return Icons.settings_outlined;
    if (lowercaseTitle.contains('notification')) {
      return Icons.notifications_outlined;
    }
    if (lowercaseTitle.contains('logout')) return Icons.logout_rounded;
    if (lowercaseTitle.contains('about us')) return Icons.group_outlined;
    if (lowercaseTitle.contains('help')) return Icons.help_outline_rounded;
    return Icons.chevron_right_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final dynamicIcon = icon ?? _getIconForTitle();

    return Animate(
      effects: [
        FadeEffect(duration: 300.ms),
        const ScaleEffect(begin: Offset(0.9, 0.9), end: Offset(1, 1)),
      ],
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLogout
                ? [Colors.red.shade50, Colors.red.shade100]
                : [Colors.white, Colors.grey.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          isLogout ? Colors.red.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      dynamicIcon,
                      color: isLogout ? Colors.red : Colors.black87,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isLogout ? Colors.red : Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isLogout ? Colors.red : Colors.black54,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
