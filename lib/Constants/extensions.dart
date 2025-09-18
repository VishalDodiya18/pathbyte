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

class Age {
  final int years;
  final int months;
  final int days;

  Age({required this.years, required this.months, required this.days});

  /// Format with leading zeros: yyyy, MM, dd
  String toFormattedString() {
    final y = years.toString().padLeft(4, '0');
    final m = months.toString().padLeft(2, '0');
    final d = days.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  @override
  String toString() => '$years years, $months months, $days days';
}

/// Parses a date string in 'dd-MM-yyyy' and returns Age relative to today.
/// Throws FormatException if the input is invalid or a future date is given.
Age calculateAgeFromString(String dobString) {
  // Normalize and split
  final parts = dobString.split(RegExp(r'[-/]')); // allow - or /
  if (parts.length != 3) {
    throw FormatException('Expected format dd-MM-yyyy');
  }

  final day = int.tryParse(parts[0].trim());
  final month = int.tryParse(parts[1].trim());
  final year = int.tryParse(parts[2].trim());

  if (day == null || month == null || year == null) {
    throw FormatException('Invalid numeric values in date');
  }

  final dob = DateTime(year, month, day);
  final today = DateTime.now();

  // Future date check
  if (dob.isAfter(today)) {
    throw FormatException('Date of birth is in the future');
  }

  int years = today.year - dob.year;
  int months = today.month - dob.month;
  int days = today.day - dob.day;

  // If days negative -> borrow from previous month
  if (days < 0) {
    // last day of previous month relative to today:
    final lastOfPrevMonth = DateTime(today.year, today.month, 0).day;
    days += lastOfPrevMonth;
    months -= 1;
  }

  // If months negative -> borrow from years
  if (months < 0) {
    years -= 1;
    months += 12;
  }

  return Age(years: years, months: months, days: days);
}

DateTime calculateDobFromAge(int years, int months, int days) {
  final today = DateTime.now();

  // पहले साल घटाएँ
  int year = today.year - years;
  int month = today.month - months;
  int day = today.day - days;

  // Days adjust
  if (day <= 0) {
    month -= 1;
    // previous month ke last din lekar adjust kare
    final prevMonthLastDay = DateTime(year, month + 1, 0).day;
    day = prevMonthLastDay + day;
  }

  // Months adjust
  if (month <= 0) {
    year -= 1;
    month += 12;
  }

  return DateTime(year, month, day);
}
