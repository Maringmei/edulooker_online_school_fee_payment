import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManualDatePicker(),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  TextEditingController dateController = TextEditingController();
  TextEditingController dateControllerTwo = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // InputText(
          //   controller: dateController,
          //   isNumber: true,
          //   hint: "Enter date",
          //   onChanged: (value) {
          //     String formattedValue =
          //         value.replaceAll("/", ""); // Remove existing slashes
          //     String newText = "";
          //
          //     // Add slashes at the right positions
          //     for (int i = 0; i < formattedValue.length; i++) {
          //       if (i == 2 || i == 4) {
          //         newText += "/";
          //       }
          //       newText += formattedValue[i];
          //     }
          //
          //     // Update the text and cursor position
          //     dateController.text = newText;
          //     dateController.selection = TextSelection.fromPosition(
          //       TextPosition(offset: newText.length),
          //     );
          //   },
          // ),
          // Form(
          //   key: formKey,
          //   child: TextFormField(
          //     controller: dateController,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       labelText: "Enter Date (DD/MM/YYYY)",
          //       border: OutlineInputBorder(),
          //     ),
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return "Date cannot be empty";
          //       }
          //
          //       // Regular expression to match DD/MM/YYYY format
          //       RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
          //       if (!dateRegex.hasMatch(value)) {
          //         return "Enter a valid date (DD/MM/YYYY)";
          //       }
          //
          //       // Split date into parts
          //       List<String> parts = value.split('/');
          //       int day = int.tryParse(parts[0]) ?? 0;
          //       int month = int.tryParse(parts[1]) ?? 0;
          //       int year = int.tryParse(parts[2]) ?? 0;
          //
          //       // Validate date using DateTime
          //       try {
          //         DateTime parsedDate = DateTime(year, month, day);
          //         if (parsedDate.year != year || parsedDate.month != month || parsedDate.day != day) {
          //           return "Enter a valid date";
          //         }
          //       } catch (e) {
          //         return "Enter a valid date";
          //       }
          //
          //       return null; // No error
          //     },
          //     onChanged: (value) {
          //       String formattedValue = value.replaceAll("/", ""); // Remove existing slashes
          //       String newText = "";
          //
          //       for (int i = 0; i < formattedValue.length; i++) {
          //         if (i == 2 || i == 4) {
          //           newText += "/";
          //         }
          //         newText += formattedValue[i];
          //       }
          //
          //       dateController.text = newText;
          //       dateController.selection = TextSelection.fromPosition(
          //         TextPosition(offset: newText.length),
          //       );
          //
          //       // Trigger form validation
          //       formKey.currentState?.validate();
          //     },
          //   )
          // ),

          //DateInputField(),
          ManualDatePicker()
        ],
      ),
    );
  }
}

class ManualDatePicker extends StatefulWidget {
  @override
  _ManualDatePickerState createState() => _ManualDatePickerState();
}

class _ManualDatePickerState extends State<ManualDatePicker> {
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController.text = ""; // Initial empty field
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a valid date (DD/MM/YYYY)";
    }
    RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return "Invalid format. Use DD/MM/YYYY";
    }
    try {
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parseStrict(value);
      if (parsedDate.year < 1900 || parsedDate.year > 2100) {
        return "Year must be between 1900 and 2100";
      }
    } catch (e) {
      return "Invalid date";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manual & Picker Date Input")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "Enter Date (DD/MM/YYYY)",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _pickDate, // Open date picker
                  ),
                ),
                validator: _validateDate,
                onChanged: (value) {
                  if (formKey.currentState != null) {
                    formKey.currentState!.validate();
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Date is valid!")),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DateInputField extends StatefulWidget {
//   @override
//   _DateInputFieldState createState() => _DateInputFieldState();
// }
//
// class _DateInputFieldState extends State<DateInputField> {
//   final TextEditingController dateController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   int lastCursorPosition = 0;
//
//   String formatDateInput(String input, int oldCursorPosition) {
//     // Remove existing slashes
//     String formattedValue = input.replaceAll("/", "");
//
//     // Limit input to 8 characters (DDMMYYYY)
//     if (formattedValue.length > 8) {
//       formattedValue = formattedValue.substring(0, 8);
//     }
//
//     String newText = "";
//     int newCursorPosition = oldCursorPosition; // Track cursor position
//
//     for (int i = 0; i < formattedValue.length; i++) {
//       if (i == 2 || i == 4) {
//         newText += "/";
//         if (i < oldCursorPosition) {
//           newCursorPosition++; // Adjust cursor position for added "/"
//         }
//       }
//       newText += formattedValue[i];
//     }
//
//     // Adjust cursor for deletion
//     if (oldCursorPosition > input.length) {
//       newCursorPosition--;
//     }
//
//     // Ensure cursor doesn't go out of bounds
//     newCursorPosition = newCursorPosition.clamp(0, newText.length);
//
//     lastCursorPosition = newCursorPosition; // Store for next update
//     return newText;
//   }
//
//   String? validateDate(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Date cannot be empty";
//     }
//
//     // Ensure correct format using RegExp
//     RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
//     if (!dateRegex.hasMatch(value)) {
//       return "Enter a valid date (DD/MM/YYYY)";
//     }
//
//     try {
//       DateFormat format = DateFormat("dd/MM/yyyy");
//       DateTime parsedDate = format.parseStrict(value);
//
//       // Ensure year is within a reasonable range
//       if (parsedDate.year < 1900 || parsedDate.year > 2100) {
//         return "Year must be between 1900 and 2100";
//       }
//
//       return null; // Valid date
//     } catch (e) {
//       return "Enter a valid date";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: TextFormField(
//         controller: dateController,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: "Enter Date (DD/MM/YYYY)",
//           border: OutlineInputBorder(),
//         ),
//         validator: validateDate,
//         onChanged: (value) {
//           int cursorPos = dateController
//               .selection.baseOffset; // Get current cursor position
//           String formattedValue = formatDateInput(value, cursorPos);
//
//           dateController.value = TextEditingValue(
//             text: formattedValue,
//             selection: TextSelection.fromPosition(
//               TextPosition(offset: lastCursorPosition),
//             ),
//           );
//
//           formKey.currentState?.validate();
//         },
//       ),
//     );
//   }
// }
