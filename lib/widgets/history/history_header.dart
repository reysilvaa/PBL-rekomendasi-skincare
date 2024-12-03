import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({
    super.key,
    this.title = 'History',
    this.height = 140,
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A4BBA).withOpacity(0.9),
            const Color(0xFF1257AA),
            const Color(0xFF0F4C9A).withOpacity(0.9),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        // Removed rounded corners to make the container a rectangle
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 7),
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        // Removed border radius to keep it rectangular
        child: Stack(
          children: [
            // Animated Background Pattern
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
                )
                    .animate()
                    .moveX(duration: 3000.ms, begin: 50, end: 0)
                    .fade(duration: 1500.ms),
              ),
            ],

            // Shimmering Gradient Effect
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0),
                    ],
                  ),
                ),
              ).animate().shimmer(
                  duration: 2000.ms, color: Colors.white.withOpacity(0.5)),
            ),

            // Main Content with Animations
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          // Removed border radius for square shape
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.history_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                          .animate()
                          .scale(duration: 500.ms, begin: const Offset(0.7, 0.7))
                          .shake(duration: 500.ms, hz: 3, rotation: 0.05),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 600.ms, delay: 300.ms)
                                .slideX(begin: -0.2, end: 0),
                            const SizedBox(height: 4),
                            Text(
                              'View your past activities',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 600.ms, delay: 300.ms)
                                .slideX(begin: -0.2, end: 0),
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
