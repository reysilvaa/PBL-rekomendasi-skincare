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

  // Open the date picker dialog and update the text field with the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default to the current date
      firstDate: DateTime(1900), // minimum date that can be selected
      lastDate: DateTime.now(), // maximum date that can be selected
    );

    if (selectedDate != null) {
      // Format the selected date into a string
      final String formattedDate =
          '${selectedDate.toLocal()}'.split(' ')[0]; // Format: YYYY-MM-DD
      _controller.text =
          formattedDate; // Update the text field with the selected date

      _onBirthDateChanged(
          formattedDate); // Update the birth date in the UserBloc
    }
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
            hintText: 'Select your birth date',
          ),
          onTap: () {
            // Prevent the keyboard from showing when tapping the text field
            FocusScope.of(context).requestFocus(FocusNode());
            _selectDate(context); // Show the date picker
          },
          readOnly: true, // Make the text field read-only
        ),
      ],
    );
  }
}
