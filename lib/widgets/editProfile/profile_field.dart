import 'package:deteksi_jerawat/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Username Field
class UsernameField extends StatelessWidget {
  final TextEditingController? controller;
  final User? user;

  const UsernameField({Key? key, this.controller, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(text: user?.username),
      decoration: InputDecoration(
        labelText: 'Username',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        return null;
      },
    );
  }
}

// Phone Number Field
class PhoneNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final User? user;

  const PhoneNumberField({Key? key, this.controller, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(text: user?.phoneNumber),
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: const Icon(Icons.phone_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a phone number';
        }
        if (value.length < 10 || value.length > 15) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }
}

class BirthDateField extends StatefulWidget {
  final String? birthDate;
  final TextEditingController? controller;

  const BirthDateField({Key? key, this.birthDate, this.controller})
      : super(key: key);

  @override
  _BirthDateFieldState createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    // Jika birthDate ada, format menjadi 'yyyy-MM-dd', jika tidak, gunakan controller kosong
    String? formattedBirthDate = widget.birthDate != null
        ? formatBirthDate(widget.birthDate!) // Fungsi untuk memformat birthDate
        : null;

    _controller = widget.controller ??
        TextEditingController(text: formattedBirthDate ?? '');
  }

  // Fungsi untuk format birthDate menjadi 'yyyy-MM-dd' jika diperlukan
  String formatBirthDate(String birthDateString) {
    try {
      // Parsing string ke DateTime
      final dateTime = DateTime.parse(birthDateString);

      // Format tanggal ke 'yyyy-MM-dd'
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      // Jika parsing gagal, kembalikan string kosong
      return '';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.birthDate != null
          ? DateTime.parse(
              widget.birthDate!) // Parse tanggal yang sudah diformat
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        // Format tanggal yang dipilih ke format yang diinginkan
        _controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Birth Date',
        prefixIcon: const Icon(Icons.calendar_today_outlined),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () => _selectDate(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your birth date';
        }

        // Tambahkan validasi jika format tanggal tidak sesuai
        try {
          DateFormat('yyyy-MM-dd').parseStrict(value);
        } catch (e) {
          return 'Invalid date format. Please use YYYY-MM-DD';
        }

        return null;
      },
    );
  }
}

// Email Field
class EmailField extends StatelessWidget {
  final String? email;
  final TextEditingController? controller;

  const EmailField({Key? key, this.email, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(text: email),
      initialValue: email,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}

// First Name Field
class FirstNameField extends StatelessWidget {
  final TextEditingController? controller;
  final User? user;

  const FirstNameField({Key? key, this.controller, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(text: user?.firstName),
      decoration: InputDecoration(
        labelText: 'First Name',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
        }
        return null;
      },
    );
  }
}

// Last Name Field
class LastNameField extends StatelessWidget {
  final TextEditingController? controller;
  final User? user;

  const LastNameField({Key? key, this.controller, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(text: user?.lastName),
      decoration: InputDecoration(
        labelText: 'Last Name',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
        }
        return null;
      },
    );
  }
}

class GenderField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String?>? onChanged;

  const GenderField({Key? key, this.initialValue, this.onChanged})
      : super(key: key);

  @override
  _GenderFieldState createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: const Icon(Icons.transgender_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: [
        DropdownMenuItem(value: 'l', child: Text('Male')),
        DropdownMenuItem(value: 'p', child: Text('Female')),
      ],
      onChanged: (newValue) {
        setState(() {
          selectedGender = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }
}

class UserLevelField extends StatelessWidget {
  final User? user;
  final ValueChanged<Level?>? onChanged;

  const UserLevelField({Key? key, this.user, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Level>(
      value: user?.level ?? Level.user,
      decoration: InputDecoration(
        labelText: 'User Level',
        prefixIcon: const Icon(Icons.admin_panel_settings_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: Level.values
          .map((level) => DropdownMenuItem(
                value: level,
                child: Text(level.toString().split('.').last),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select a user level';
        }
        return null;
      },
    );
  }
}
