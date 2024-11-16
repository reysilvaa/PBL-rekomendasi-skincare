import 'package:deteksi_jerawat/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String message;

  const ErrorCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(16),
        child: Material(
          color: Colors.transparent,
          child: Card(
            color: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Oh No!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedOpacity(
                    opacity: 1.0, // Initially visible
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedScale(
                    scale:
                        1.0, // Scale in (adjust to 0.8 or any value for animation)
                    duration: const Duration(milliseconds: 400),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                      child: const Text(
                        'Go Back to Main Screen',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
