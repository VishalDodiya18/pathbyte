import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/utils/app_color.dart';

class YMDInput extends StatelessWidget {
  const YMDInput({
    super.key,
    required this.yearsCtrl,
    required this.monthsCtrl,
    required this.daysCtrl,
    this.onChanged,
    this.height = 48,
    this.radius = 16,
  });

  final TextEditingController yearsCtrl;
  final TextEditingController monthsCtrl;
  final TextEditingController daysCtrl;
  final void Function({int? years, int? months, int? days})? onChanged;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.secondarycolor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Years
          Expanded(
            child: segment(
              unit: 'Y',
              controller: yearsCtrl,
              maxDigits: 3, // up to 999 years; change as you like
              onParsed: (v) => onChanged?.call(
                years: v,
                months: int.tryParse(monthsCtrl.text),
                days: int.tryParse(daysCtrl.text),
              ),
            ),
          ),
          Container(width: 1),
          // Months
          Expanded(
            child: segment(
              unit: 'M',
              controller: monthsCtrl,
              maxDigits: 2,
              // clamp 0–12
              validator: (v) => v == null ? null : v.clamp(0, 12),
              onParsed: (v) => onChanged?.call(
                years: int.tryParse(yearsCtrl.text),
                months: v,
                days: int.tryParse(daysCtrl.text),
              ),
            ),
          ),
          Container(width: 1),
          // Days
          Expanded(
            child: segment(
              unit: 'D',
              controller: daysCtrl,
              maxDigits: 2,
              // clamp 0–31
              validator: (v) => v == null ? null : v.clamp(0, 31),
              onParsed: (v) => onChanged?.call(
                years: int.tryParse(yearsCtrl.text),
                months: int.tryParse(monthsCtrl.text),
                days: v,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget segment({
    required String unit,
    required TextEditingController controller,
    required int maxDigits,
    int? Function(int?)? validator,
    void Function(int?)? onParsed,
  }) {
    return SizedBox.expand(
      child: Row(
        children: [
          // number field
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                isDense: true,
                //contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(maxDigits),
              ],
              onChanged: (txt) {
                int? v = int.tryParse(txt);
                if (validator != null) v = validator(v);
                // write back clamped value if needed
                final newText = v?.toString() ?? '';
                if (newText != txt) {
                  // keep caret at end
                  controller
                    ..text = newText
                    ..selection = TextSelection.collapsed(
                      offset: newText.length,
                    );
                }
                onParsed?.call(v);
              },
            ),
          ),
          // unit chip area
          Container(
            width: 35.w,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffF5F6F8),
              borderRadius: BorderRadius.only(
                topRight: unit == 'D' ? Radius.circular(12.r) : Radius.zero,
                bottomRight: unit == 'D' ? Radius.circular(12.r) : Radius.zero,
              ),
            ),
            child: TextConstant(
              title: unit,
              fontSize: 14,
              color: Colors.black.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildRow(
  String label,
  bool isHighlighted, {
  bool iswidget = false,
  String? value,
  Widget? customwidget,
}) {
  return Container(
    decoration: BoxDecoration(
      color: isHighlighted ? const Color(0xFFF5E6A3) : Colors.transparent,
      border: Border.all(color: AppColor.secondarycolor),
    ),

    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: TextConstant(
              title: label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IntrinsicHeight(
          child: Container(
            width: 1,
            height: 50,
            color: AppColor.secondarycolor,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: iswidget
                      ? customwidget ?? const SizedBox()
                      : TextConstant(
                          title: value ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                ),
                if (isHighlighted) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.warning, color: Colors.red[600], size: 20),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDivider() {
  return const Divider(height: 1, thickness: 1, color: AppColor.secondarycolor);
}
