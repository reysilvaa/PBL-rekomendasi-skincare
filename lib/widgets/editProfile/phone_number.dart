import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';

class PhoneNumberField extends StatefulWidget {
  final User user;

  const PhoneNumberField({Key? key, required this.user}) : super(key: key);

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged(String newPhoneNumber) {
      context.read<UserBloc>().add(UpdateUserFieldEvent('phone_number', newPhoneNumber)); // Use the correct event for first name
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: 'Enter your phone number',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(
              Icons.phone,
              color: Color(0xFF0D47A1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 2),
            ),
          ),
          onChanged: _onPhoneNumberChanged,
        ),
      ],
    );
  }
}
