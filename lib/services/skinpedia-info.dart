// lib/services/skinpedia_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/skinpedia.dart'; // Import the Skinpedia model
import 'auth.dart'; // Import Auth for token
import 'config.dart'; // Import config for the base URL

class SkinpediaService {
  final Auth _auth = Auth(); // Instance from Auth to get token

  Future<List<Skinpedia>> fetchSkinpedia() async {
    try {
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('Authentication failed: No access token');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/skinpedia'), // Endpoint for skinpedia
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success' && data['data'] is List) {
          List<dynamic> skinpediaList = data['data'];

          return skinpediaList
              .map((skinpediaJson) => Skinpedia.fromJson(skinpediaJson))
              .toList();
        } else {
          throw Exception('Invalid skinpedia data format or empty data');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetch skinpedia error: $e');
      return []; // Return an empty list to avoid null reference errors
    }
  }
}
