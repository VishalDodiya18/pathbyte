import 'package:flutter/material.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

SetString(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

GetString(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "null";
}

PreferredSizeWidget CustomAppBar({
  required title,
  bool? centerTitle,
  List<Widget>? actions,
  FontWeight? fontWeight,
  bool automaticallyImplyLeading = false,
  String? leading,
  textColor,
  fontSize,
  iconColor,
}) {
  return AppBar(
    centerTitle: centerTitle ?? true,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: Text(
      title,
      style: TextStyle(
        fontSize: fontSize ?? 17.0,
        color: textColor ?? AppColor.blackcolor,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    ),
    leading: leading == "null"
        ? null
        : BackButton(color: iconColor ?? AppColor.blackcolor),
    actions: actions,
  );
}

extension StringExtension on String {
  String get getInitials {
    if (isEmpty) return '';

    final List<String> nameParts = trim().split(' ');

    final initials = nameParts
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase())
        .take(2)
        .join('');

    return initials;
  }
}
