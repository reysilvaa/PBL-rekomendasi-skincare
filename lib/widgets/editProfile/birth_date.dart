import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user/user_bloc.dart'; // Import UserBloc
import '../../blocs/user/user_event.dart'; // Import UserEvent

class BirthDateField extends StatefulWidget {
  final String? birthDate;

  const BirthDateField({
    Key? key,
    required this.birthDate,
  }) : super(key: key);

  @override
  _BirthDateFieldState createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.birthDate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBirthDateChanged(String newBirthDate) {
    context.read<UserBloc>().add(
        UpdateBirthDateEvent(newBirthDate)); // Handle the birth date change
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Birth Date',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your birth date',
          ),
          onChanged: _onBirthDateChanged,
        ),
      ],
    );
  }
}
