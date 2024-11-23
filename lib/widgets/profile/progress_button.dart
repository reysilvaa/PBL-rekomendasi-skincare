import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProgressButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Padding luar tombol
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Gradasi dengan warna terang
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Sudut bulat
          ),
          elevation: 6, // Shadow untuk efek kedalaman
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFA726), Color(0xFFFF7043)], // Warna gradasi
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20, // Padding vertikal tombol
              horizontal: 24, // Padding horizontal tombol
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Check your progress',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18, // Ukuran font lebih besar
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Jarak antara teks dan ikon
                const Icon(
                  Icons.timer,
                  color: Colors.white,
                  size: 28, // Ukuran ikon lebih besar
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
