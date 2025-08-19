import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labapp/Constants/text_constant.dart';

Widget elevatedButton(
    {required String title,
      required void Function()? onPressed,
      Color? backgroundColor,
      double? width,
      bool isEnable = true,
      Color? textColor,
      Color borderColor = Colors.transparent,
      double? height,
      double? fontSize,
      FontWeight? fontWeight = FontWeight.w600,
      bool isleftIcon = false,
      bool isrightIcon = false,
      Widget? Icon}) {
  return SizedBox(
    width: width ?? Get.width,
    height: height ?? 50.h,
    child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
          ),
          backgroundColor: WidgetStatePropertyAll(isEnable ? backgroundColor ?? Color(0xFF2E37A4) : Colors.grey),
          elevation: const WidgetStatePropertyAll(0.0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                color: borderColor,
              ),
            ),
          ),
        ),
        onPressed: isEnable ? onPressed : null,
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isleftIcon) Icon!,
            TextConstant(
              title: title,
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight,
            ),
            if (isrightIcon) Icon!,
          ],
        )),
  );
}