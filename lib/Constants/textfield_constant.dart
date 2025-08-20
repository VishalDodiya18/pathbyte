// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:inventory/utils/commons/text_constant.dart';
// import 'package:inventory/utils/theme_controller.dart';
// //
// // class TextFieldConstant extends StatelessWidget {
// //   TextFieldConstant({
// //     super.key,
// //     required this.controller,
// //     this.contentPadding,
// //     this.keyboardType,
// //     this.prefixIcon,
// //     this.suffixIcon,
// //     this.suffixOnTap,
// //     this.prefixOnTap,
// //     this.onTap,
// //     this.obscureText = false,
// //     this.isReadOnly = false,
// //     this.maxLines = 1, // Default is 1 line
// //     this.minLines, // Optional min lines
// //     required this.hintText,
// //     this.onChanged,
// //     this.validator,
// //     this.textAlign = TextAlign.start,
// //     this.inputFormatters,
// //   });
// //
// //   final TextEditingController controller;
// //   final EdgeInsets? contentPadding;
// //   final TextInputType? keyboardType;
// //   final dynamic suffixIcon;
// //   final dynamic? prefixIcon;
// //   final VoidCallback? suffixOnTap;
// //   final VoidCallback? prefixOnTap;
// //   final bool obscureText;
// //   final String hintText;
// //   final Function(String)? onChanged;
// //   final String? Function(String?)? validator;
// //   final void Function()? onTap;
// //   final bool isReadOnly;
// //   final int? maxLines; // Added maxLines
// //   final int? minLines; // Added minLines
// //   final List<TextInputFormatter>? inputFormatters;
// //   final ThemeController themeController = Get.find();
// //   final TextAlign textAlign;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Access the current theme's colors using Theme.of(context)
// //     final theme = Theme.of(context);
// //
// //     final Color fillColor = themeController.whiteColor; // Use secondary color for the fill
// //
// //     return TextFormField(
// //       controller: controller,
// //       // cursorColor: themeController.blackColor,
// //       onTap: onTap,
// //       keyboardType: keyboardType,
// //       obscureText: obscureText,
// //       style: textStyle(fontSize: 14),
// //       // Set the text color based on the theme
// //       onChanged: onChanged,
// //       validator: validator,
// //       readOnly: isReadOnly,
// //       maxLines: maxLines,
// //       // Set max lines
// //       minLines: minLines,
// //       // Set min lines
// //       textAlign: textAlign,
// //       inputFormatters: inputFormatters,
// //       decoration: InputDecoration(
// //         hintText: hintText,
// //         hintStyle: textStyle(fontSize: 14, color: theme.hintColor),
// //         prefixIcon:
// //             prefixIcon != null
// //                 ? prefixIcon is IconData
// //                     ? GestureDetector(onTap: prefixOnTap, child: Icon(prefixIcon, color: themeController.greyColor))
// //                     : prefixIcon
// //                 : null,
// //         suffixIcon:
// //             suffixIcon != null
// //                 ? suffixIcon is IconData
// //                     ? GestureDetector(onTap: suffixOnTap, child: Icon(suffixIcon, color: themeController.greyColor))
// //                     : suffixIcon
// //                 : null,
// //         fillColor: fillColor,
// //         filled: true,
// //         contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
// //         disabledBorder: OutlineInputBorder(
// //           borderSide: BorderSide(color: themeController.transparentColor),
// //           borderRadius: BorderRadius.circular(20.r),
// //         ),
// //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: themeController.transparentColor), borderRadius: BorderRadius.circular(20.r)),
// //         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: themeController.transparentColor), borderRadius: BorderRadius.circular(20.r)),
// //         errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: const BorderSide(color: Colors.red, width: 1.0)),
// //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: const BorderSide(width: 1.0)),
// //       ),
// //     );
// //   }
// // }
//
// class TextFieldConstant extends StatelessWidget {
//   TextFieldConstant({
//     super.key,
//     required this.controller,
//     this.contentPadding,
//     this.keyboardType,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.suffixOnTap,
//     this.prefixOnTap,
//     this.onTap,
//     this.obscureText = false,
//     this.isReadOnly = false,
//     this.maxLines = 1,
//     this.minLines,
//     required this.hintText,
//     this.onChanged,
//     this.validator,
//     this.textAlign = TextAlign.start,
//     this.inputFormatters,
//   });
//
//   final TextEditingController controller;
//   final EdgeInsets? contentPadding;
//   final TextInputType? keyboardType;
//   final dynamic suffixIcon;
//   final dynamic? prefixIcon;
//   final VoidCallback? suffixOnTap;
//   final VoidCallback? prefixOnTap;
//   final bool obscureText;
//   final String hintText;
//   final Function(String)? onChanged;
//   final String? Function(String?)? validator;
//   final void Function()? onTap;
//   final bool isReadOnly;
//   final int? maxLines;
//   final int? minLines;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextAlign textAlign;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return TextFormField(
//       controller: controller,
//       onTap: onTap,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       readOnly: isReadOnly,
//       maxLines: maxLines,
//       minLines: minLines,
//       textAlign: textAlign,
//       inputFormatters: inputFormatters,
//       onChanged: onChanged,
//       validator: validator,
//       style: textStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color),
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: textStyle(fontSize: 14, color: theme.hintColor),
//         prefixIcon:
//             prefixIcon != null
//                 ? (prefixIcon is IconData ? GestureDetector(onTap: prefixOnTap, child: Icon(prefixIcon, color: theme.iconTheme.color)) : prefixIcon)
//                 : null,
//         suffixIcon:
//             suffixIcon != null
//                 ? (suffixIcon is IconData
//                     ? GestureDetector(
//                       onTap: suffixOnTap,
//                       child: Padding(padding: EdgeInsets.only(right: 20.0.w), child: Icon(suffixIcon, color: theme.iconTheme.color)),
//                     )
//                     : suffixIcon)
//                 : null,
//         fillColor: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.secondary.withOpacity(0.2),
//         filled: true,
//         contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
//         disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20.r)),
//         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20.r)),
//         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(20.r)),
//         errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: const BorderSide(color: Colors.red, width: 1.0)),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: const BorderSide(width: 1.0)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/utils/app_color.dart';

class TextFieldConstant extends StatelessWidget {
  const TextFieldConstant({
    super.key,
    required this.controller,
    this.contentPadding,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnTap,
    this.prefixOnTap,
    this.onTap,
    this.fillColor,
    this.obscureText = false,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.minLines,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmit,
    this.validator,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final dynamic suffixIcon;
  final dynamic prefixIcon;
  final VoidCallback? suffixOnTap;
  final VoidCallback? prefixOnTap;
  final bool obscureText;
  final String hintText;
  final Color? fillColor;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmit;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool isReadOnly;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: isReadOnly,
      maxLines: maxLines,
      minLines: minLines,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmit,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      style: textStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle(fontSize: 14, color: theme.hintColor),
        alignLabelWithHint: true,
        prefixIcon: prefixIcon != null
            ? (prefixIcon is IconData
                  ? Padding(
                      padding: EdgeInsets.only(
                        bottom: maxLines == 1 ? 0 : 70.h,
                      ),
                      child: GestureDetector(
                        onTap: prefixOnTap,
                        child: Icon(prefixIcon),
                      ),
                    )
                  : prefixIcon)
            : null,
        suffixIcon: suffixIcon != null
            ? (suffixIcon is IconData
                  ? GestureDetector(
                      onTap: suffixOnTap,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0.0.w),
                        child: Icon(suffixIcon, size: 28.0.h),
                      ),
                    )
                  : suffixIcon)
            : null,
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        isDense: T,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.w),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.secondarycolor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.secondarycolor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.secondarycolor),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1.0),
        ),
      ),
    );
  }
}

InputDecoration buildInputDecoration({
  required BuildContext context,
  required String hintText,
  String? label,
  Color? fillColor,
  EdgeInsets? contentPadding,
  dynamic prefixIcon,
  dynamic suffixIcon,
  VoidCallback? suffixOnTap,
  VoidCallback? prefixOnTap,
}) {
  final theme = Theme.of(context);

  return InputDecoration(
    labelText: label,
    labelStyle: textStyle(color: theme.hintColor),
    hintText: label != null ? null : hintText,
    alignLabelWithHint: true,
    hintStyle: textStyle(fontSize: 16, color: theme.hintColor),
    prefixIcon: prefixIcon != null
        ? (prefixIcon is IconData
              ? GestureDetector(
                  onTap: prefixOnTap,
                  child: Icon(prefixIcon, color: Colors.black),
                )
              : prefixIcon)
        : null,
    suffixIcon: suffixIcon != null
        ? (suffixIcon is IconData
              ? GestureDetector(
                  onTap: suffixOnTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0.w),
                    child: Icon(suffixIcon, color: Colors.black),
                  ),
                )
              : suffixIcon)
        : null,
    fillColor: fillColor ?? Colors.transparent,
    filled: true,
    // isDense: true,
    contentPadding:
        contentPadding ?? EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.secondarycolor),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.secondarycolor),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.secondarycolor),
      borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(width: 1.0),
    ),
  );
}

class TextValidations {
  TextInputFormatter noSpace() {
    return FilteringTextInputFormatter.deny(RegExp(r'[ ]'));
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address.';
    }

    // Regular expression to match valid email addresses
    String pattern =
        r"^(?![.])([a-zA-Z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'+/=?^_`{|}~-]+)*)@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$";
    RegExp regex = RegExp(pattern);

    // Additional check for consecutive dots
    if (!regex.hasMatch(value) || value.contains('..')) {
      return 'Enter provide a valid email address.';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 10) {
      return 'Password must be at least 10 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}

class LimitedDoubleInputFormatter extends TextInputFormatter {
  final int maxIntegerDigits;
  final int decimalPlaces;

  LimitedDoubleInputFormatter(this.maxIntegerDigits, {this.decimalPlaces = 2});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Allow empty value
    if (newText.isEmpty) {
      return newValue;
    }

    // Check for valid double input using regex
    final regExp = RegExp(r'^\d*\.?\d*$');
    if (!regExp.hasMatch(newText)) {
      return oldValue;
    }

    // Split integer and decimal parts
    List<String> parts = newText.split('.');
    String integerPart = parts[0];

    // Limit integer digits
    if (integerPart.length > maxIntegerDigits) {
      return oldValue;
    }

    // Limit decimal digits
    if (parts.length > 1 && parts[1].length > decimalPlaces) {
      return oldValue;
    }

    return newValue;
  }
}

class LimitedIntegerInputFormatter extends TextInputFormatter {
  final int maxLength;

  LimitedIntegerInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Allow empty value
    if (newText.isEmpty) return newValue;

    // Only digits allowed
    if (!RegExp(r'^\d+$').hasMatch(newText)) {
      return oldValue;
    }

    // Limit to maxLength digits
    if (newText.length > maxLength) {
      return oldValue;
    }

    return newValue;
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  final RegExp _allowedRegex = RegExp(r'^[\d\s\-\+\(\)]*$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_allowedRegex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
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
