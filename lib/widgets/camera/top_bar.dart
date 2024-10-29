import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onClose;

  const TopBar({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              onClose(); // Memanggil fungsi onClose saat ikon diklik
            },
            child: const Icon(Icons.close, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
