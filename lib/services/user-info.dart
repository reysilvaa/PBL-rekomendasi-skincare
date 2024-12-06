import 'dart:convert';
import 'package:deteksi_jerawat/services/config.dart';
import 'package:deteksi_jerawat/services/edit-profile-image-post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'auth.dart';

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

      print('Fetching user info with token: $token');

      final response = await http.get(
        Uri.parse('${Config.baseUrl}/user/profile-info'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['user'] != null) {
          print('User data received: ${data['user']}');
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

      print('Updating user profile with token: $token');
      print('User data: ${user.toJson()}'); // Debugging: print the user data

      // Membuat body dalam format x-www-form-urlencoded
      final body = {
        'username': user.username ?? 'Null',
        'first_name': user.firstName ?? 'Null',
        'last_name': user.lastName ?? 'Null',
        'birth_date': user.birthDate ?? 'DatetIME kosong',
        'phone_number': user.phoneNumber ?? 'Null',
        'email': user.email ?? 'Null',
        'gender': user.gender ?? 'Null',
        'age': user.age?.toString() ?? '0',
        'level': 'user', // Convert level to string
      };

      print('Request body: $body'); // Debugging: print the request body

      final response = await http.put(
        Uri.parse('${Config.baseUrl}/user/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type':
              'application/x-www-form-urlencoded', // Ensure the correct content type
        },
        body: body, // Send the data in URL-encoded format
      );

      print('Response status: ${response.statusCode}');
      print(
          'Response body: ${response.body}'); // Print the full response body for debugging

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['user'] != null) {
          return User.fromJson(data['user']);
        } else {
          throw Exception('User data not found in the response.');
        }
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

      print('Updating profile image with token: $token');

      // Call ImageUploadService to pick and upload image
      final profileImagePath =
          await _imageUploadService.pickImageAndUpload(token);

      print('Profile image uploaded: $profileImagePath');

      return profileImagePath;
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      throw Exception('Failed to update profile image: $e');
    }
  }

  // Method to get full image URL from relative path
  String getFullImageUrl(String relativePath) {
    print('Generating full image URL for: $relativePath');
    return relativePath;
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late Future<User> _userInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _userInfo = UserInfoService().fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<User>(
        future: _userInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data!;
            print('User data: ${user.toJson()}'); // Debugging the user data
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Username: ${user.username}'),
                  Text('Full Name: ${user.firstName} ${user.lastName}'),
                  // Add other user details here
                ],
              ),
            );
          }

          return Center(
            child: Text('No user data available'),
          );
        },
      ),
    );
  }
}
