import 'dart:convert';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/history.dart';
import 'auth.dart';

class HistoryService {
  final Auth _auth = Auth();
  Future<List<History>> fetchUserHistory() async {
    try {
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/user/history'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Print the response body for debugging purposes
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        // Check if 'status' and 'data' are present
        if (decodedResponse is Map) {
          // Handle success response
          if (decodedResponse.containsKey('status') &&
              decodedResponse.containsKey('data')) {
            final status = decodedResponse['status'];
            if (status == 'success') {
              final List<dynamic> data = decodedResponse['data'];
              return data.map((item) => History.fromJson(item)).toList();
            } else {
              throw Exception('No Data Found!: $status');
            }
          }

          if (decodedResponse.containsKey('message')) {
            final message = decodedResponse['message'];
            throw (message); // Display the message from the API
          }

          // Handle unexpected structure
          throw Exception(
              'Unexpected response structure: Missing "status" or "data"');
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw ('No Data Found!: ${response.statusCode}');
      }
    } catch (e) {
      throw ('$e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Menambahkan riwayat baru menggunakan token
  Future<History> addHistory(History history) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.post(
        Uri.parse('${Config.baseUrl}/history/add'),
        headers: {
          'Authorization':
              'Bearer $token', // Hanya menggunakan token untuk autentikasi
          'Content-Type': 'application/json',
        },
        body: json.encode(history.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return History.fromJson(data);
      } else {
        throw Exception('Failed to add history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Memperbarui riwayat berdasarkan token
  Future<History> updateHistory(History history) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse('${Config.baseUrl}/history/update/${history.historyId}'),
        headers: {
          'Authorization':
              'Bearer $token', // Hanya menggunakan token untuk autentikasi
          'Content-Type': 'application/json',
        },
        body: json.encode(history.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return History.fromJson(data);
      } else {
        throw Exception('Failed to update history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Menghapus riwayat berdasarkan token dan historyId
  Future<void> deleteHistory(int historyId) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.delete(
        Uri.parse('${Config.baseUrl}/history/delete/$historyId'),
        headers: {
          'Authorization':
              'Bearer $token', // Hanya menggunakan token untuk autentikasi
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
