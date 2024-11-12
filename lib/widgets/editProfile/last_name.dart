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
    context.read<UserBloc>().add(
        UpdateLastNameEvent(newLastName)); // Dispatch event to update last name
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last Name',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your last name',
          ),
          onChanged: _onLastNameChanged, // Trigger event when text changes
        ),
      ],
    );
  }
}
