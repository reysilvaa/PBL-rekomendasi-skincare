import 'package:flutter/material.dart';
import 'lib/time_based_content.dart'; // Import the time_based_content.dart file

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard>
    with SingleTickerProviderStateMixin {
  late String _greeting;
  late String _message;
  late Color _startColor;
  late Color _endColor;
  late String _weatherIcon;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Call the external method to update content
    TimeBasedContent.updateTimeBasedContent(
      DateTime.now(),
      (greeting) => setState(() => _greeting = greeting),
      (message) => setState(() => _message = message),
      (startColor) => setState(() => _startColor = startColor),
      (endColor) => setState(() => _endColor = endColor),
      (weatherIcon) => setState(() => _weatherIcon = weatherIcon),
    );

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available width for the content
          final double availableWidth =
              constraints.maxWidth - 32.0; // 32 for padding
          final bool isSmallScreen = availableWidth < 350;

          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_startColor, _endColor],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _startColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Use FittedBox to scale down the greeting text if necessary
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _greeting,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _message,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15,
                              height: 1.5,
                              letterSpacing: 0.2,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          // Conditionally adjust button width
                          SizedBox(
                            width: isSmallScreen
                                ? double.infinity
                                : null, // Full width on small screens
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: _startColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Start Routine',
                                      style: TextStyle(
                                        color: _startColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: _startColor,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Conditionally adjust image size and use Flexible
                    Flexible(
                      child: SizedBox(
                        width: isSmallScreen
                            ? availableWidth * 0.4
                            : availableWidth * 0.3,
                        height: isSmallScreen
                            ? availableWidth * 0.4
                            : availableWidth * 0.3,
                        child: Stack(
                          children: [
                            Image.asset(
                              _weatherIcon,
                              fit: BoxFit.contain,
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.2),
                                      Colors.white.withOpacity(0),
                                    ],
                                    center: Alignment.center,
                                    radius: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
