import 'package:flutter/material.dart';
import '../widgets/historyCheckout/historyCheckout_card.dart';
import '../widgets/historyCheckout/historyCheckout_header.dart';

class HistoryCheckoutScreen extends StatelessWidget {
  const HistoryCheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HistoryCheckoutHeader(),
          Expanded(
            child: ListView(
              children: [
                HistoryCheckoutCard(
                  sellerName: 'Wardah',
                  productName: 'Skincare Product',
                  productImage: 'https://via.placeholder.com/60',
                  originalPrice: 12500,
                  discountedPrice: 12400,
                  quantity: 2,
                  totalPrice: 26792,
                  status: 'Selesai',
                ),
                HistoryCheckoutCard(
                  sellerName: 'Skintific',
                  productName: 'Skincare Product',
                  productImage: 'https://via.placeholder.com/60',
                  originalPrice: 12999,
                  discountedPrice: 9880,
                  quantity: 1,
                  totalPrice: 11880,
                  status: 'Selesai',
                ),
                HistoryCheckoutCard(
                  sellerName: 'MS Glow',
                  productName: 'Skincare Product',
                  productImage: 'https://via.placeholder.com/60',
                  originalPrice: 99000,
                  discountedPrice: 39500,
                  quantity: 1,
                  totalPrice: 35219,
                  status: 'Selesai',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}