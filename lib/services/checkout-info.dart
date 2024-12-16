// lib/services/checkout_info.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/checkout.dart'; // Import the Checkout model
import 'auth.dart'; // Import Auth for token
import 'config.dart'; // Import config for the base URL

class CheckoutService {
  final Auth _auth = Auth(); // Instance from Auth to get token

  // Method to fetch user checkouts
  Future<List<Checkout>> fetchCheckouts() async {
    try {
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('Authentication failed: No access token');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/getCheckout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success' && data['data'] is List) {
          List<dynamic> checkoutList = data['data'];
          return checkoutList
              .map((checkoutJson) => Checkout.fromJson(checkoutJson))
              .toList();
        } else {
          throw Exception('Invalid checkout data format or empty data');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch checkouts error: $e');
      return [];
    }
  }

  // Method to create a new checkout
  Future<bool> createCheckout(
      int historyId, int productId, int quantity) async {
    try {
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('Authentication failed: No access token');
      }

      final response = await http.post(
        Uri.parse(
            '${Config.baseUrl}/checkout'), // Endpoint for creating a checkout
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'history_id': historyId,
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          return true; // Checkout created successfully
        } else {
          throw Exception('Failed to create checkout: ${data['message']}');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Create checkout error: $e');
      return false; // Indicate failure
    }
  }
}
