import 'dart:convert';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:deteksi_jerawat/services/edit-profile-image-post.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'auth.dart';
import 'edit-profile-image-post.dart'; // Import service image upload

class UserInfoService {
  final Auth _auth = Auth(); // Instance of Auth
  final ProfileImagePOST _imageUploadService =
      ProfileImagePOST(); // Instance of ImageUploadService

  // Fetch user info based on token
  Future<User> fetchUserInfo() async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/user/profile-info'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Debugging the response
      print('Response status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['user'] != null) {
          return User.fromJson(data['user']);
        } else {
          throw Exception('User data not found in the response.');
        }
      } else {
        throw Exception('Failed to fetch user info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      throw Exception('Network error: $e');
    }
  }

  // Update user profile (without profile image)
  Future<User> updateUserProfile(User user) async {
    try {
      final token = await _auth.getAccessToken();

      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      final response = await http.put(
        Uri.parse('${Config.baseUrl}/user/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': user.username,
          'first_name': user.firstName,
          'last_name': user.lastName,
          'birth_date': user.birthDate,
          'phone_number': user.phoneNumber,
          'email': user.email,
          'gender': user.gender,
          'age': user.age,
          'level': user.level,
        }),
      );

      // Debugging the response
      print('Response status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return User.fromJson(data['user']);
      } else {
        throw Exception(
            'Failed to update user profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      throw Exception('Network error: $e');
    }
  }

  // Update profile image using the same token
  Future<String> updateProfileImage() async {
    try {
      // Get the token from Auth service
      final token = await _auth.getAccessToken();
      if (token == null) {
        throw Exception('No access token found in SharedPreferences');
      }

      // Call ImageUploadService to pick and upload image
      final profileImagePath =
          await _imageUploadService.pickImageAndUpload(token);

      print('Profile image uploaded successfully: $profileImagePath');
      return profileImagePath;
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      throw Exception('Failed to update profile image: $e');
    }
  }

  // Method to get full image URL from relative path
  String getFullImageUrl(String relativePath) {
    return relativePath;
  }
}
