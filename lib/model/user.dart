import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String? email;
  final String? profileImage;
  final String? gender;
  final int? age;
  final String? level;
  final String? password;
  final String? confirmPassword;
  final String? phoneNumber; // Added
  final String? firstName; // Added
  final String? lastName; // Added
  final String? birthDate; // Added

  const User({
    required this.username,
    this.email,
    this.profileImage,
    this.gender,
    this.age,
    this.level,
    this.password,
    this.confirmPassword,
    this.phoneNumber, // Added
    this.firstName, // Added
    this.lastName, // Added
    this.birthDate, // Added
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String?,
      profileImage: json['profile_image'],
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      level: json['level'] as String?,
      phoneNumber: json['phone_number'] as String?, // Added
      firstName: json['first_name'] as String?, // Added
      lastName: json['last_name'] as String?, // Added
      birthDate: json['birth_date'] as String?, // Added
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'profile_image': profileImage,
        'gender': gender,
        'age': age,
        'level': level,
        'phone_number': phoneNumber, // Added
        'first_name': firstName, // Added
        'last_name': lastName, // Added
        'birth_date': birthDate, // Added
      };

  bool isValid() {
    // Check for valid username and password (if they exist), and if passwords match
    if (password != null && confirmPassword != null) {
      return username.isNotEmpty &&
          password!.isNotEmpty &&
          confirmPassword!.isNotEmpty &&
          password == confirmPassword;
    }
    return username.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        username,
        email,
        profileImage,
        gender,
        age,
        level,
        password,
        confirmPassword,
        phoneNumber, // Added
        firstName, // Added
        lastName, // Added
        birthDate, // Added
      ];

  User copyWith({
    String? username,
    String? email,
    String? profileImage,
    String? gender,
    int? age,
    String? level,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? birthDate,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      level: level ?? this.level,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
