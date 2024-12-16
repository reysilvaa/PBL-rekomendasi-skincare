import 'package:flutter/material.dart';

// OrderSummarySection.dart
class OrderSummarySection extends StatelessWidget {
  final double productPrice;
  final int quantity;
  final Function(int) onQuantityChanged;
  final int shippingFee;
  final int serviceFee;
  final int handlingFee;

  const OrderSummarySection({
    super.key,
    required this.productPrice,
    required this.quantity,
    required this.onQuantityChanged,
    required this.shippingFee,
    required this.serviceFee,
    required this.handlingFee,
  });

  @override
  Widget build(BuildContext context) {
    double productSubtotal = productPrice * quantity;
    double totalPayment =
        productSubtotal + shippingFee + serviceFee + handlingFee;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quantity'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        onQuantityChanged(quantity - 1);
                      }
                    },
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      onQuantityChanged(quantity + 1);
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          buildSummaryRow(
              'Subtotal Produk', 'Rp${productSubtotal.toStringAsFixed(0)}'),
          buildSummaryRow('Subtotal Pengiriman', 'Rp${shippingFee.toString()}'),
          buildSummaryRow('Biaya Layanan', 'Rp${serviceFee.toString()}'),
          buildSummaryRow('Biaya Penanganan', 'Rp${handlingFee.toString()}'),
          const SizedBox(height: 8),
          buildSummaryRow(
            'Total Pembayaran',
            'Rp${totalPayment.toStringAsFixed(0)}',
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
          Text(
            label,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            amount,
            style: TextStyle(color: isTotal ? Colors.blue : Colors.black),
          ),
        ],
      ),
    );
  }
}
