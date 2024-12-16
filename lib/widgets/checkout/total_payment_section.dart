import 'package:flutter/material.dart';
import 'package:deteksi_jerawat/services/checkout-info.dart'; // Import CheckoutService

class TotalPaymentSection extends StatelessWidget {
  final double productPrice;
  final int shippingFee;
  final int serviceFee;
  final int handlingFee;
  final int quantity;
  final int historyId; // Add this to represent the user's order history ID
  final int productId; // Add this to represent the product ID
  final Function(int) onQuantityChanged;

  const TotalPaymentSection({
    super.key,
    required this.productPrice,
    required this.shippingFee,
    required this.serviceFee,
    required this.handlingFee,
    required this.quantity,
    required this.historyId,
    required this.productId,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate subtotal and total payment
    double productSubtotal = productPrice * quantity;
    double totalPayment =
        productSubtotal + shippingFee + serviceFee + handlingFee;

    // Create an instance of CheckoutService
    final CheckoutService checkoutService = CheckoutService();

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                'Rp${totalPayment.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              // Call the CheckoutService to create the checkout
              bool success = await checkoutService.createCheckout(
                historyId, // Pass the order history ID
                productId, // Pass the product ID
                quantity, // Pass the quantity
              );

              // Show a dialog based on whether the checkout was successful or not
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(success ? 'Pesanan Berhasil' : 'Pesanan Gagal'),
                    content: Text(
                      success
                          ? 'Pesanan Anda telah dibuat. Total: Rp${totalPayment.toStringAsFixed(0)}'
                          : 'Terjadi kesalahan saat membuat pesanan. Silakan coba lagi.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
