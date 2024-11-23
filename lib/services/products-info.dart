// lib/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart'; // Import model Product
import 'auth.dart'; // Import Auth for token
import 'config.dart'; // Import config for the base URL

class ProductService {
  final Auth _auth = Auth(); // Instance from Auth to get token

  Future<List<Product>> fetchProducts() async {
    try {
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('Authentication failed: No access token');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/products'), // No page parameter here
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success' && data['data'] is List) {
          List<dynamic> productList = data['data'];

          return productList
              .map((productJson) => Product.fromJson(productJson))
              .toList();
        } else {
          throw Exception('Invalid product data format or empty data');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch products error: $e');
      return []; // Return an empty list to avoid null reference errors
    }
  }
}
