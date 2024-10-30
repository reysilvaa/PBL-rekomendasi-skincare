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
      padding:
          const EdgeInsets.symmetric(horizontal: 10), // Padding di luar tombol
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // Menggunakan warna latar belakang cerah
          backgroundColor: Colors.amber,
          padding: const EdgeInsets.symmetric(
              vertical: 20), // Padding vertikal di dalam tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Sudut bulat
          ),
          // Menghilangkan shadow
          elevation: 0,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15), // Tambah padding horizontal di dalam tombol
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Mengatur jarak antara teks dan ikon
            children: [
              Expanded(
                // Menggunakan Expanded agar teks mengambil ruang yang tersisa
                child: Text(
                  'Check your progress',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Ukuran font diperbesar
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20), // Jarak antara teks dan ikon
              const Icon(Icons.timer,
                  color: Colors.white, size: 24), // Ikon di sebelah kanan
            ],
          ),
        ),
      ),
    );
  }
}
