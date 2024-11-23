import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:deteksi_jerawat/model/recommendation.dart';
import 'auth.dart';

class ScanService {
  final ImagePicker _picker = ImagePicker();
  final Auth _auth = Auth();

  Future<Recommendation> analyzeImage(File imageFile, String token) async {
    try {
      final mimeType = lookupMimeType(imageFile.path);
      final contentType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType.parse('image/jpeg');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Config.baseUrl}/analyze-skin'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: contentType,
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Parse the response into your Recommendation model
        final recommendation = Recommendation.fromJson(
          Map<String, dynamic>.from(
            json.decode(response.body) as Map,
          ),
        );
        return recommendation;
      } else {
        throw Exception(
            'Failed to analyze image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Image analysis failed: $e');
    }
  }

  Future<File> pickImage({ImageSource source = ImageSource.camera}) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) {
        throw Exception('No image selected');
      }
      return File(image.path);
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  Future<Recommendation> pickAndAnalyzeImage({
    required String token,
    ImageSource source = ImageSource.camera,
  }) async {
    final File image = await pickImage(source: source);
    return analyzeImage(image, token);
  }
}
