import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String? profileImage;
  final String? gender;
  final int? age;
  final String? level;
  final String? password;
  final String? confirmPassword;

  const User({
    required this.username,
    required this.email,
    this.profileImage,
    this.gender,
    this.age,
    this.level,
    this.password,
    this.confirmPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      level: json['level'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'profile_image': profileImage,
        'gender': gender,
        'age': age,
        'level': level,
      };

  bool isValid() {
    if (password != null && confirmPassword != null) {
      return email.isNotEmpty &&
          username.isNotEmpty &&
          password!.isNotEmpty &&
          confirmPassword!.isNotEmpty &&
          password == confirmPassword;
    }
    return email.isNotEmpty && username.isNotEmpty;
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
    );
  }
}
