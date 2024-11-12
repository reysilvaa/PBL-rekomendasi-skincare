import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user/user_bloc.dart'; // Import UserBloc
import '../../blocs/user/user_event.dart'; // Import UserEvent

class EmailField extends StatefulWidget {
  final String? email;

  const EmailField({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEmailChanged(String newEmail) {
    context.read<UserBloc>().add(UpdateEmailEvent(newEmail));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your email',
          ),
          onChanged: _onEmailChanged,
        ),
      ],
    );
  }
}
