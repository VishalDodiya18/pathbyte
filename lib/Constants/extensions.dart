import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

String getDobFromAge(int years, int months, int days, {format}) {
  DateTime today = DateTime.now();

  // Pehle years minus karte hain
  DateTime dob = DateTime(today.year - years, today.month, today.day);

  // Months minus
  dob = DateTime(dob.year, dob.month - months, dob.day);

  // Days minus
  dob = dob.subtract(Duration(days: days));

  // Format date (dd-MM-yyyy)
  return DateFormat(format ?? 'dd-MM-yyyy').format(dob);
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
