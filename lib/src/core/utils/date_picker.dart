import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'date_format.dart';

Future<(String?, String?, String?, String?)> datePicker(
    BuildContext context) async {
  String? sDate;
  String? eDate;
  String? dateFormat;
  String? defaultFormat;
  DateTime now = DateTime.now();
  DateTime lastDayOfMonth = DateTime(now.year, now.month, now.day);

  List<DateTime?>? results = await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime(1990),
        lastDate: DateTime.now()),
    dialogSize: const Size(325, 400),
    borderRadius: BorderRadius.circular(15),
  );

  if (results != null && results.isNotEmpty) {
    if (results!.length == 1) {
      sDate = DateFormat('yyyy-MM-dd').format(results[0]!);
      eDate = DateFormat('yyyy-MM-dd').format(results[0]!);
      defaultFormat = DateFormat('dd/MM/yyyy').format(results[0]!);
      print("The selected date is $defaultFormat");
      dateFormat = formatDate(sDate);
    } else {
      sDate = DateFormat('yyyy-MM-dd').format(results[0]!);
      eDate = DateFormat('yyyy-MM-dd').format(results[1]!);
      defaultFormat = DateFormat('dd/MM/yyyy').format(results[0]!);
      print("The selected date is $defaultFormat");
      dateFormat = formatDate(sDate);
    }
    return (sDate, eDate, dateFormat, defaultFormat);
  } else {
    return (null, null, null, null);
  }
}
