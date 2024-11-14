import 'dart:convert';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:http/http.dart' as http;
import '../model/history.dart';
import 'auth.dart';

class HistoryService {
  final Auth _auth = Auth();

  // Mengambil riwayat berdasarkan token saja
  Future<List<History>> fetchUserHistory() async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse(
            '${Config.baseUrl}/user/history'), // endpoint untuk fetch history
        headers: {
          'Authorization':
              'Bearer $token', // Hanya menggunakan token untuk autentikasi
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          final decodedResponse = json.decode(response.body);

          // Check if the response contains 'status' and 'data'
          if (decodedResponse is Map &&
              decodedResponse.containsKey('status') &&
              decodedResponse.containsKey('data')) {
            final status = decodedResponse['status'];
            final List<dynamic> data = decodedResponse['data'];

            // Check for 'success' status
            if (status == 'success') {
              return data.map((item) => History.fromJson(item)).toList();
            } else {
              throw Exception('Failed to fetch history: $status');
            }
          } else {
            throw Exception(
                'Unexpected response structure: Missing "status" or "data"');
          }
        } catch (e) {
          throw Exception('Error decoding history data: $e');
        }
      } else {
        throw Exception('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
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
