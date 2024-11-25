import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dt_picker;
import 'package:intl/intl.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_event.dart';

class BirthDateField extends StatefulWidget {
  final String? birthDate;

  const BirthDateField({Key? key, required this.birthDate}) : super(key: key);

  @override
  _BirthDateFieldState createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  late final TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.birthDate != null
        ? DateFormat('yyyy-MM-dd').parse(widget.birthDate!)
        : null;
    _controller = TextEditingController(
      text: _selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateBirthDate(DateTime newDate) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
    context
        .read<UserBloc>()
        .add(UpdateUserFieldEvent('birthDate', formattedDate));

    setState(() {
      _selectedDate = newDate;
      _controller.text = formattedDate;
    });
  }

  void _selectDate(BuildContext context) {
    dt_picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      currentTime: _selectedDate ?? DateTime.now(),
      locale: dt_picker.LocaleType.en,
      theme: dt_picker.DatePickerTheme(
        // Use the alias here
        backgroundColor: Colors.white,
        itemStyle: const TextStyle(color: Colors.black, fontSize: 18),
        doneStyle: const TextStyle(color: Color(0xFF0D47A1), fontSize: 16),
        cancelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
      onConfirm: (date) {
        _updateBirthDate(date);
      },
    );
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
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
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
              readOnly: false,
            ),
          ),
        ),
      ],
    );
  }
}
