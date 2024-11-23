import 'package:flutter/material.dart';

class TotalPaymentSection extends StatelessWidget {
  final double totalPrice; // Total harga dari API

  const TotalPaymentSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Informasi total pembayaran
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                'Rp${totalPrice.toStringAsFixed(0)}', // Menampilkan total harga
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Tombol untuk membuat pesanan
          ElevatedButton(
            onPressed: () {
              // Implementasikan logika pemesanan
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pesanan Berhasil'),
                    content: const Text('Pesanan Anda telah dibuat.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Menutup dialog
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Buat Pesanan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
