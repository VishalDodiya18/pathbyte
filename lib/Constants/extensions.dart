import 'package:intl/intl.dart';

String formatIndianCurrency(num amount) {
  final format = NumberFormat.currency(
    locale: 'en_IN', // Indian format
    symbol: '₹', // ₹ symbol add karega
    decimalDigits: 0, // 2 decimal places
  );
  return format.format(amount);
}

String getFullAddress(dynamic address) {
  if (address == null) return "";

  // Sirf non-empty fields select karenge
  final parts = [
    address.line1,
    address.line2,
    address.city,
    address.state,
    address.postalCode,
    address.country,
  ].where((e) => e != null && e.trim().isNotEmpty).toList();

  return parts.join(", ");
}
