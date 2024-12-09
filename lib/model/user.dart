import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum Level {
  admin,
  user,
}

class User extends Equatable {
  final String username;
  final String? email;
  final String? profileImage;
  final String? gender;
  final int? age;
  final Level? level; // enum Level
  final String? password;
  final String? confirmPassword;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? birthDate;
  final String? address;

  const User({
    required this.username,
    this.email,
    this.profileImage,
    this.gender,
    this.age,
    this.level,
    this.password,
    this.confirmPassword,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.address,
  });

  // Parsing enum Level from String or int value (from database or API)
  static Level? _parseLevel(dynamic level) {
    if (level == null) return null;

    if (level is String) {
      return Level.values.firstWhere(
        (e) => e.toString().split('.').last == level,
        orElse: () => Level.user, // Default to 'user' if no match
      );
    } else if (level is int) {
      if (level >= 0 && level < Level.values.length) {
        return Level.values[level];
      }
    }

    return Level.user; // Default if type is unexpected
  }

  // Converting enum Level to String for storing in the database
  String? _levelToString() {
    return level?.toString().split('.').last;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      profileImage: json['profile_image'],
      gender: json['gender'],
      age: json['age'] is int
          ? json['age']
          : int.tryParse(json['age']?.toString() ?? ''),
      level: _parseLevel(json['level']),
      phoneNumber: json['phone_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthDate: json['birth_date'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'username': username,
      'email': email,
      'profile_image': profileImage,
      'gender': gender,
      'age': age, // Ensure age is sent as int
      'level': _levelToString(),
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'address': address,
    };

    return jsonMap;
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
        phoneNumber,
        firstName,
        lastName,
        birthDate,
        address,
      ];

  User copyWith({
    String? username,
    String? email,
    String? profileImage,
    String? gender,
    int? age,
    Level? level,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? address,
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
      address: address ?? this.address,
    );
  }

  static int? calculateAge(String birthDate) {
    try {
      final DateTime? birthDateTime =
          DateFormat('yyyy-MM-dd').tryParse(birthDate);
      final DateTime currentDate = DateTime.now();

      if (birthDateTime == null) return null;

      int age = currentDate.year - birthDateTime.year;

      if (currentDate.month < birthDateTime.month ||
          (currentDate.month == birthDateTime.month &&
              currentDate.day < birthDateTime.day)) {
        age--;
      }

      return age;
    } catch (_) {
      return null;
    }
  }

  factory User.withCalculatedAge({
    required String username,
    String? email,
    String? profileImage,
    String? gender,
    required String birthDate,
    Level? level,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? address,
  }) {
    final age = calculateAge(birthDate);
    return User(
      username: username,
      email: email,
      profileImage: profileImage,
      gender: gender,
      age: age,
      level: level,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      address: address,
    );
  }
}
