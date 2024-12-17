import 'dart:convert';
import 'dart:io';
import 'package:deteksi_jerawat/model/scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:image/image.dart' as img; // Import package image
import 'dart:typed_data';

class ScanService {
  final ImagePicker _picker = ImagePicker();

  // Fungsi kompresi gambar menggunakan package 'image'
  Future<File> compressImage(File imageFile) async {
    try {
      // Membaca file gambar ke dalam bentuk bytes
      List<int> imageBytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

      if (image == null) {
        throw Exception('Failed to decode image');
      }

      // Mengubah ukuran gambar menjadi 800x800 dan mengompresnya dengan kualitas 80%
      img.Image resizedImage = img.copyResize(image, width: 800, height: 800);
      List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 80);

      // Menyimpan gambar yang sudah terkompresi ke file baru
      final targetPath =
          imageFile.path.replaceFirst(RegExp(r'\.jpg$'), '_compressed.jpg');
      final compressedFile = File(targetPath)
        ..writeAsBytesSync(compressedBytes);

      return compressedFile;
    } catch (e) {
      print('Error during compression: $e');
      throw Exception('Compression failed: $e');
    }
  }

  // Fungsi untuk menganalisis gambar
  Future<Scan> analyzeImage(File imageFile, String token) async {
    try {
      // Kompresi gambar terlebih dahulu
      final compressedImage = await compressImage(imageFile);

      // Menentukan tipe konten gambar
      final mimeType = lookupMimeType(compressedImage.path);
      final contentType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType.parse('image/jpeg');

      // Membuat request HTTP untuk mengirim gambar ke server
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Config.baseUrl}/analyze-skin'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      // Menambahkan file gambar terkompresi ke dalam request
      print('Image file added to request: ${compressedImage.path}');
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        compressedImage.path,
        contentType: contentType,
      ));

      // Mengirim request dan menunggu respons dari server
      print('Request sent, waiting for response...');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Menangani respons dari server
      print('Response received with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        // Mengonversi data respons JSON ke model Scan
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final scanResult = Scan.fromJson(responseData);
        print('Image analysis successful, scan result: $scanResult');
        return scanResult;
      } else {
        throw Exception(
            'Failed to analyze image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image analysis: $e');
      throw Exception('Image analysis failed: $e');
    }
  }

  // Fungsi untuk memilih gambar dari kamera atau galeri
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

  // Fungsi untuk memilih dan menganalisis gambar
  Future<Scan> pickAndAnalyzeImage({
    required String token,
    ImageSource source = ImageSource.camera,
  }) async {
    final File image = await pickImage(source: source);
    return analyzeImage(image, token);
  }
}
