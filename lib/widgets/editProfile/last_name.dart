import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user.dart'; // Import User model
import '../../blocs/user/user_event.dart';
import '../../blocs/user/user_bloc.dart'; // Import UserBloc

class LastNameField extends StatefulWidget {
  final User user; // Expect the entire User object

  const LastNameField({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _LastNameFieldState createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<LastNameField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.user.lastName); // Access lastName from User model
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLastNameChanged(String newLastName) {
      context.read<UserBloc>().add(UpdateUserFieldEvent('last_name', newLastName)); // Use the correct event for first name

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last Name',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          onChanged: _onLastNameChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: 'Enter your last name',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(
              Icons.person_outline,
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
        ),
      ],
    );
  }
}
