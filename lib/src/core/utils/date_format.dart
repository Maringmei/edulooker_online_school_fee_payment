import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if(dateString != null){
    // Parse the input date string
    DateTime date = DateTime.parse(dateString!);

    // Format the date to get the day, month, and year separately
    String day = DateFormat('d').format(date);
    String month = DateFormat('MMMM').format(date);
    String year = DateFormat('yyyy').format(date);

    // Add the appropriate ordinal suffix to the day
    String dayWithSuffix = _addOrdinalSuffix(int.parse(day));

    // Return the formatted date string
    return '$dayWithSuffix $month $year';
  }else{
    return "-----";
  }

}

String formatDateShort(String? dateString) {
  if (dateString != null) {
    // Parse the input date string
    DateTime date = DateTime.parse(dateString);

    // Format the date to get the day, abbreviated month, and year
    String day = DateFormat('d').format(date);
    String month = DateFormat('MMM').format(date);  // Abbreviated month
    String year = DateFormat('yyyy').format(date);

    // Add the appropriate ordinal suffix to the day
    String dayWithSuffix = _addOrdinalSuffix(int.parse(day));

    // Return the formatted date string
    return '$dayWithSuffix $month $year';
  } else {
    return "-----";
  }
}

String convertDateFormat(String dateStr) {
  DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(dateStr);
  return DateFormat("yyyy-MM-dd").format(parsedDate);
}

String _addOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return '${day}th';
  }
  switch (day % 10) {
    case 1:
      return '${day}st';
    case 2:
      return '${day}nd';
    case 3:
      return '${day}rd';
    default:
      return '${day}th';
  }
}

// void main() {
//   String formattedDate = formatDate("2024-05-03");
//   print(formattedDate); // Output: 3rd May 2024
// }
