import 'package:flutter/material.dart';
import 'profile_field.dart';

class BirthDateField extends StatelessWidget {
  const BirthDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileField(
      label: 'Date of Birth',
      value: '29/9/2003',
    );
  }
}
