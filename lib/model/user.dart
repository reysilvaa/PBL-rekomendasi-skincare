class User {
  String email;
  String username;
  // String phone;
  String password;
  String confirmPassword;

  User({
    required this.email,
    required this.username,
    // required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  // Optionally, you can add a method to validate the user
  bool isValid() {
    return email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
  }
}
