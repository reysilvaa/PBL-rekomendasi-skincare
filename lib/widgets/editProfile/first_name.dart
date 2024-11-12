import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';

class FirstNameField extends StatefulWidget {
  final User user; // Change to User model

  const FirstNameField({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _FirstNameFieldState createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.user.firstName); // Access firstName from User
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFirstNameChanged(String newFirstName) {
    context.read<UserBloc>().add(UpdateFirstNameEvent(
        newFirstName)); // Use the correct event for first name
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'First Name',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your first name',
          ),
          onChanged: _onFirstNameChanged, // Trigger event when text changes
        ),
      ],
    );
  }
}
