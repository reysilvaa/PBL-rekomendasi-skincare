import 'dart:io' as io;
import 'package:flutter/foundation.dart'; // Import this to use kIsWeb
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:deteksi_jerawat/services/config.dart';

class ImageUploadService {
  final ImagePicker _picker = ImagePicker();

  // Metode untuk memilih gambar dari galeri dan mengunggahnya langsung
  Future<String> pickImageAndUpload() async {
    // Pilih gambar dari galeri
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        // Jika platform adalah Web, gunakan Blob untuk mengirim file
        if (kIsWeb) {
          // For web, you would need to use a different method for uploading the image
          // For example, using FormData in web or other API-compatible solutions
          // This is a simplified placeholder for web upload
          print('Image selected for web upload: ${image.path}');
          // Placeholder response - modify this according to your web backend
          return "http://your-web-image-upload-endpoint.com/image.jpg"; // Modify as per your backend
        } else {
          // Platform is mobile (Android/iOS), use dart:io and MultipartRequest
          final imageFile = io.File(image.path);

          // Menentukan tipe mime berdasarkan ekstensi file
          final mimeType = lookupMimeType(image.path);
          final contentType = mimeType != null
              ? MediaType.parse(mimeType)
              : MediaType.parse('image/jpeg'); // Default ke 'image/jpeg'

          // Membuat request untuk mengunggah gambar
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                '${Config.baseUrl}/user/update-profile-image'), // Ganti dengan endpoint server yang sesuai
          );

          // Menambahkan file ke request
          var pic = await http.MultipartFile.fromPath(
            'image', // Parameter yang diharapkan oleh server
            imageFile.path,
            contentType: contentType, // Mengatur tipe konten secara dinamis
          );

          request.files.add(pic);

          // Mengirim request untuk mengunggah gambar
          var response = await request.send();

          // Mengecek apakah upload berhasil
          if (response.statusCode == 200) {
            var responseBody = await response.stream.bytesToString();
            print('Image uploaded successfully: $responseBody');
            return responseBody; // Kembalikan URL atau path gambar yang diunggah
          } else {
            throw Exception(
                'Failed to upload image with status code: ${response.statusCode}');
          }
        }
      } catch (e) {
        throw Exception('Image upload failed: $e');
      }
    } else {
      throw Exception('No image selected');
    }
  }
}
