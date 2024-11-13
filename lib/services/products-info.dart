// lib/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart'; // Import model Product
import 'auth.dart'; // Import Auth for token
import 'config.dart'; // Import config for the base URL

class ProductService {
  final Auth _auth = Auth(); // Instance from Auth to get token

  // Updated fetchProducts method to accept a page parameter
  Future<List<Product>> fetchProducts({int page = 1}) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/products?page=$page'), // Passing the page in the query string
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success' && data['data'] != null) {
          List<Product> products = (data['data'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();
          return products;
        } else {
          throw Exception('No products found or error: ${data['message']}');
        }
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
