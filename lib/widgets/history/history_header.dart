import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({
    super.key,
    this.title = 'History',
    this.height = 120,
    this.showPattern = true,
  });

  final String title;
  final double height;
  final bool showPattern;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A4BBA),
            Color(0xFF1257AA),
            Color(0xFF0F4C9A),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        child: Stack(
          children: [
            // Background pattern
            if (showPattern) ...[
              Positioned(
                right: -75,
                top: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.15,
                  child: Transform.scale(
                    scaleX: -1,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/pattern.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              // Additional left pattern with lower opacity
              Positioned(
                left: -100,
                top: -20,
                child: Opacity(
                  opacity: 0.08,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/pattern.png',
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ],

            // Shimmer effect line
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.history_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'View your past activities',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
