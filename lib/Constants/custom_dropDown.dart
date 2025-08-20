import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemLabel;
  final String hintText;
  final IconData prefixIcon;
  final void Function(T?) onChanged;
  final double? dropdownHeight;
  final Color? backgroundColor;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    this.selectedValue,
    this.dropdownHeight,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      child: DropdownButton2<T>(
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: TextConstant(
                  title: itemLabel(item),
                  fontFamily: 'M',
                  fontSize: 16,
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          maxHeight: dropdownHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          elevation: 4,
        ),
        isExpanded: false,
        underline: const SizedBox.shrink(),
        customButton: Container(
          height: 50.h,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              TextConstant(
                title: selectedValue != null
                    ? itemLabel(selectedValue!)
                    : hintText,
                fontSize: 16,
                color: selectedValue != null ? null : theme.hintColor,
              ),
              Spacer(),
              Icon(
                TablerIcons.chevron_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
