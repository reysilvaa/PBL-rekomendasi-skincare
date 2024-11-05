import 'package:flutter/material.dart';
import 'profile_field.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileField(
      label: 'Username',
      value: 'abimafadricho',
    );
  }
}
