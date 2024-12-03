import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  const InstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          'Take the front side face',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
