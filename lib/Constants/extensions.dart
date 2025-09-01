import 'package:intl/intl.dart';

String formatIndianCurrency(num amount) {
  final format = NumberFormat.currency(
    locale: 'en_IN', // Indian format
    symbol: '₹', // ₹ symbol add karega
    decimalDigits: 0, // 2 decimal places
  );
  return format.format(amount);
}
