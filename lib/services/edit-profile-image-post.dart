import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:deteksi_jerawat/services/config.dart';
import 'auth.dart';

class ProfileImagePOST {
  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker
  final Auth _auth = Auth(); // Instance of Auth

  // Method to pick and upload image, now takes the token as a parameter
  Future<String> pickImageAndUpload(String token) async {
    try {
      // Pick an image from the gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        throw Exception('No image selected');
      }

      final imageFile = io.File(image.path);
      final mimeType = lookupMimeType(image.path);
      final contentType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType.parse('image/jpeg');

      // Create request for uploading the image
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Config.baseUrl}/user/update-profile-image'),
      );

      // Add headers including authorization token
      request.headers['Authorization'] = 'Bearer $token';

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        imageFile.path,
        contentType: contentType,
      ));

      // Send the request
      var response = await request.send();

      // Check for successful response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        return responseBody; // Return URL/path of the uploaded image
      } else {
        throw Exception(
            'Failed to upload image with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }
}
