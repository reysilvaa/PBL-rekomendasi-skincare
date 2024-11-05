import 'package:flutter/material.dart';
import 'profile_field.dart';

class FirstNameField extends StatelessWidget {
  const FirstNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileField(
      label: 'First Name',
      value: 'Abima',
    );
  }
}
