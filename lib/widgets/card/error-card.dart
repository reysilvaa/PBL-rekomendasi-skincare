import 'package:deteksi_jerawat/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String message;

  const ErrorCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: 1.0, // Fade-in effect
        duration: const Duration(milliseconds: 500),
        child: Material(
          color: Colors.transparent,
          child: AnimatedScale(
            scale: 1.0, // Scale up the card slightly
            duration: const Duration(milliseconds: 400),
            child: Card(
              color: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Oops!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    AnimatedScale(
                      scale: 1.0, // Scale-in animation for button
                      duration: const Duration(milliseconds: 400),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red.shade600,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Go Back to Main Screen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
