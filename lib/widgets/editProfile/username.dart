import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/user.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';

class UsernameField extends StatefulWidget {
  final User user;

  const UsernameField({Key? key, required this.user}) : super(key: key);

  @override
  _UsernameFieldState createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.username);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onUsernameChanged(String newUsername) {
    context.read<UserBloc>().add(UpdateUsernameEvent(newUsername));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Username',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your username',
          ),
          onChanged: _onUsernameChanged,
        ),
      ],
    );
  }
}
