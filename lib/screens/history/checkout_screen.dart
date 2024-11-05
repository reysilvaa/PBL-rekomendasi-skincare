import 'package:flutter/material.dart';
import '../../widgets/checkout/address_section.dart';
import '../../widgets/checkout/order_section.dart';
import '../../widgets/checkout/product_detail_section.dart';
import '../../widgets/checkout/total_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout', 
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            AddressSection(),
            ProductDetailSection(),
            OrderSummarySection(),
            TotalPaymentSection(),
          ],
        ),
      ),
    );
  }
}
