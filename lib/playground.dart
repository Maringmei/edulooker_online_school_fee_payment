import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateChanged;
  final String labelText;
  final String helperText;

  const CustomDatePicker({
    Key? key,
    required this.onDateChanged,
    this.initialDate = const DateTime(2025, 3, 6),
    this.firstDate = const DateTime(2020),
    this.lastDate = const DateTime(2030),
    this.labelText = 'Select a date',
    this.helperText = '',
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _dateController = TextEditingController(
      text: DateFormat('MMM d, yyyy').format(_selectedDate),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _dateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: widget.labelText,
            helperText: widget.helperText,
            suffixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MMM d, yyyy').format(_selectedDate);
      });
      widget.onDateChanged(_selectedDate);
    }
  }
}

// Example usage in a StatefulWidget
class DatePickerExample extends StatefulWidget {
  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              labelText: 'Select a date',
              helperText: 'Tap to open calendar',
              onDateChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
                print('Selected date: ${DateFormat('yyyy-MM-dd').format(date)}');
              },
            ),
            SizedBox(height: 24),
            Text(
              'Selected date: ${DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}