// lib/widgets/checkout/order_summary_section.dart
import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[100]!, width: 9.0),
          bottom: BorderSide(color: Colors.grey[100]!, width: 9.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rincian Pembayaran',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          buildSummaryRow('Subtotal Produk', 'Rp50.000'),
          buildSummaryRow('Subtotal Pengiriman', 'Rp10.000'),
          buildSummaryRow('Biaya Layanan', 'Rp1.000'),
          buildSummaryRow('Biaya Penanganan', 'Rp1.000'),
          const SizedBox(height: 8),
          buildSummaryRow(
            'Total Pembayaran',
            'Rp62.000',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(color: isTotal ? Colors.blue : Colors.black)),
        ],
      ),
    );
  }
}
