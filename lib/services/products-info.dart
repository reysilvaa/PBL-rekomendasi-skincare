// lib/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart'; // Import model Product yang sesuai
import 'auth.dart'; // Import Auth untuk mendapatkan token
import 'config.dart'; // Import konfigurasi

class ProductService {
  final Auth _auth = Auth(); // Instance dari Auth untuk mengambil token

  Future<List<Product>> fetchProducts() async {
    try {
      // Ambil token dari Auth
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse(
            '${Config.baseUrl}/products'), // Menggunakan baseUrl dari Config
        headers: {
          'Authorization': 'Bearer $token', // Sertakan token di header
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Menangani format response Laravel
        if (data['status'] == 'success' && data['data'] != null) {
          // Mengambil data produk
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
