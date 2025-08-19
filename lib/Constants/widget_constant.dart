import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum PickerMode { date, time, both }

double height = MediaQuery.sizeOf(Get.context!).height;
double width = MediaQuery.sizeOf(Get.context!).width;


SizedBox heightBox(int height) {
  return SizedBox(height: height.h);
}

SizedBox widthBox(int width) {
  return SizedBox(width: width.h);
}

Future<DateTime?> pickDateTime({
  required BuildContext context,
  PickerMode mode = PickerMode.both,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  DateTime now = DateTime.now();
  DateTime initial = initialDate ?? now;
  DateTime start = firstDate ?? DateTime(now.year - 100);
  DateTime end = lastDate ?? DateTime(now.year + 100);

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  print("This is start date : ${start}");
  if (mode == PickerMode.date || mode == PickerMode.both) {
    selectedDate = await showDatePicker(context: context, initialDate: initial, firstDate: start, lastDate: end);

    if (selectedDate == null) return null;
  }

  if (mode == PickerMode.time || mode == PickerMode.both) {
    selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initial));
    if (selectedTime == null) return null;
  }

  if (mode == PickerMode.date) {
    return DateTime(selectedDate!.year, selectedDate.month, selectedDate.day);
  } else if (mode == PickerMode.time) {
    return DateTime(now.year, now.month, now.day, selectedTime!.hour, selectedTime.minute);
  } else {
    return DateTime(selectedDate!.year, selectedDate.month, selectedDate.day, selectedTime!.hour, selectedTime.minute);
  }
}