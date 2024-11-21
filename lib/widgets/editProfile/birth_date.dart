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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF0D47A1), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      final String formattedDate =
          '${selectedDate.toLocal()}'.split(' ')[0]; // Format: YYYY-MM-DD
      _controller.text = formattedDate;
      _onBirthDateChanged(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Birth Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _selectDate(context);
          },
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Select your birth date',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              suffixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF0D47A1),
              ),
            ),
            readOnly: true, // Prevent keyboard display
          ),
        ),
      ],
    );
  }
}
