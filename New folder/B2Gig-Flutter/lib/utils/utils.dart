import 'package:intl/intl.dart';

// class DateFormatter {
//
//   static DateFormat dateFormat = DateFormat("dd-MM-yyyy hh:mm a");
//
//   static String formatDate(DateTime date) => dateFormat.format(date);
// }

String generateInvoiceNumber(String date) {
  return date.replaceAll(new RegExp(r"\D"), "");
}

String formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}