import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; // Importing mime for MediaType

Future<String> pickImageAndUpload() async {
  final ImagePicker picker = ImagePicker();

  // Pick an image from the gallery
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    try {
      final imageFile = File(image.path);

      // Detect mime type from file extension
      final mimeType = lookupMimeType(image.path);
      final contentType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType.parse(
              'image/jpeg'); // Default to 'image/jpeg' if mime type is unknown

      // Create a request for uploading the image
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:8000/user/update-profile-image'), // Replace with your server URL
      );

      // Attach the file to the request
      var pic = await http.MultipartFile.fromPath(
        'image', // Parameter expected by the server
        imageFile.path,
        contentType: contentType, // Set content type dynamically
      );

      request.files.add(pic);

      // Send the request
      var response = await request.send();

      // Check if the upload was successful
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Image uploaded successfully: $responseBody');
        return responseBody; // Return the URL or path of the uploaded image
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  } else {
    throw Exception('No image selected');
  }
}
