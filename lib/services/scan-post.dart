import 'dart:convert';
import 'dart:io';
import 'package:deteksi_jerawat/model/scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:deteksi_jerawat/services/config.dart';
import 'auth.dart';

class ScanService {
  final ImagePicker _picker = ImagePicker();
  final Auth _auth = Auth();

  Future<Scan> analyzeImage(File imageFile, String token) async {
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

      // Log the file path and type
      print('Image file added to request: ${imageFile.path}');

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: contentType,
      ));

      print('Request sent, waiting for response...');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Log response details
      print('Response received with status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        // Parse the response using the Scan model
        final scanResult = Scan.fromJson(responseData);

        print('Image analysis successful, scan result: $scanResult');

        return scanResult;
      } else {
        throw Exception(
            'Failed to analyze image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error
      print('Error during image analysis: $e');
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

  Future<Scan> pickAndAnalyzeImage({
    required String token,
    ImageSource source = ImageSource.camera,
  }) async {
    final File image = await pickImage(source: source);
    return analyzeImage(image, token);
  }
}
