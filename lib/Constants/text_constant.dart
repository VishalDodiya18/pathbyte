import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextConstant extends StatelessWidget {
  const TextConstant({
    required this.title,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.overflow,
    super.key,
    this.textAlign,
    this.maxLines,
    this.height,
    this.textDecoration,
    this.fontFamily,
    this.decorationColor,
    this.softWrap = true,
  });

  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final String title;
  final String? fontFamily;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    // Accessing theme's color scheme to adapt text color as per the theme
    final theme = Theme.of(context);
    final Color defaultColor =
        theme.colorScheme.onSurface; // Theme-aware default text color

    return Text(
      title,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      style: textStyle(
        fontSize: fontSize,
        fontFamily: fontFamily ?? "Inter",
        fontWeight: fontWeight,
        color:
            color ??
            defaultColor, // Apply theme color if no specific color is provided
        height: height,
        textDecoration: textDecoration,
        decorationColor: decorationColor,
      ),
      maxLines: maxLines ?? 5,
    );
  }
}

TextStyle textStyle({
  FontWeight? fontWeight,
  String? fontFamily,
  Color? color,
  double? fontSize,
  double? height,
  TextDecoration? textDecoration,
  Color? decorationColor,
}) {
  return TextStyle(
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color,
    fontSize: fontSize != null ? fontSize.sp : 14.sp,
    height: height ?? 0,
    fontFamily: fontFamily ?? '',
    decoration: textDecoration,
    decorationColor: decorationColor,
  );
}
