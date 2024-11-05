import 'package:flutter/material.dart';
import 'profile_field.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileField(
      label: 'Email',
      value: 'abima@gmail.com',
    );
  }
}
