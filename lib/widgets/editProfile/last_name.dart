import 'package:flutter/material.dart';
import 'profile_field.dart';

class LastNameField extends StatelessWidget {
  const LastNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileField(
      label: 'Last Name',
      value: 'Fadricho',
    );
  }
}
