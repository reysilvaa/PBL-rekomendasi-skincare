import 'package:flutter/material.dart';
import 'profile_field.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileField(
      label: 'Phone Number',
      value: '08 **** ****',
    );
  }
}
