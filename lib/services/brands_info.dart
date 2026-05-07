// lib/services/product_service.dart
import 'dart:convert';
import 'package:deteksi_jerawat/model/brands.dart';
import 'package:http/http.dart' as http;
import 'auth.dart'; // Import Auth for token
import 'config.dart'; // Import config for the base URL

class BrandService {
  final Auth _auth = Auth(); // Instance from Auth to get token

  // Fetch brands from the API
  Future<List<Brand>> fetchBrands() async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/brands'), // API endpoint to fetch brands
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success' && data['data'] != null) {
          // Parse brand data from the response and return a list of Brand objects
          List<Brand> brands = (data['data'] as List)
              .map((brandJson) => Brand.fromJson(brandJson))
              .toList();
          return brands;
        } else {
          throw Exception('No brands found or error: ${data['message']}');
        }
      } else {
        throw Exception('Failed to fetch brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
