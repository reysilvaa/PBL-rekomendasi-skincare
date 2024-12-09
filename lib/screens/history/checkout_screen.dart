import 'package:deteksi_jerawat/model/product.dart';
import 'package:flutter/material.dart';
import '../../services/user-info.dart';
import '../../widgets/checkout/address_section.dart';
import '../../widgets/checkout/order_section.dart';
import '../../widgets/checkout/product_detail_section.dart';
import '../../widgets/checkout/total_payment_section.dart';

class CheckoutScreen extends StatefulWidget {
  final Product product;

  const CheckoutScreen({super.key, required this.product});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? initialAddress;
  final UserInfoService _userInfoService = UserInfoService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserAddress();
  }

  Future<void> _loadUserAddress() async {
    try {
      final userInfo = await _userInfoService.fetchUserInfo();
      setState(() {
        initialAddress = userInfo.address;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading user address: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AddressSection(
                    initialAddress: initialAddress,
                    onAddressChanged: () {
                      // Perform any action after address is changed
                      print('Address updated');
                      // Could be navigation, showing a dialog, etc.
                    },
                  ),
                  ProductDetailSection(product: widget.product),
                  const OrderSummarySection(),
                  TotalPaymentSection(totalPrice: widget.product.price),
                ],
              ),
            ),
    );
  }
}
