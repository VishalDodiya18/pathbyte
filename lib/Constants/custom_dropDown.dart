import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/utils/app_color.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemLabel;
  final String hintText;
  final IconData prefixIcon;
  final void Function(T?) onChanged;
  final double? dropdownHeight;
  final Color? backgroundColor;
  final String? Function(T?)? validator;
  BoxConstraints? constraints;
  bool ischange;

  CustomDropdown({
    Key? key,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.hintText,
    required this.prefixIcon,
    this.selectedValue,
    this.dropdownHeight,
    this.backgroundColor,
    this.constraints,
    this.validator,
    this.ischange = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<T>(
      initialValue: selectedValue,
      validator: validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton2<T>(
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
              isDense: true,

              onChanged: ischange
                  ? (val) {
                      onChanged(val);
                      state.didChange(val);
                    }
                  : null,
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
                constraints: constraints ?? BoxConstraints(minHeight: 47.h),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: state.hasError
                        ? Colors.red
                        : AppColor.secondarycolor,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: TextConstant(
                        title: selectedValue != null
                            ? itemLabel(selectedValue!)
                            : hintText,
                        fontSize: 15,
                        color: selectedValue != null ? null : theme.hintColor,
                      ),
                    ),
                    Icon(
                      TablerIcons.chevron_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError) // ✅ Show error
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 8),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
