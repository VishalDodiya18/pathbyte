import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labapp/Constants/custom_dropDown.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/utils/app_color.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextConstant(
                    title: "Apply Filters",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Date Range Picker
              const TextConstant(
                title: "Registration Date Range",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: TextFieldConstant(
                      onTap: () async {
                        DateTime? result = await pickDateTime(
                          context: Get.context!,
                          firstDate: DateTime(DateTime.now().year - 100),
                          initialDate: DateTime.now(),
                          mode: PickerMode.date,
                        );
                        if (result != null) {
                          final formattedDate = DateFormat(
                            'd MMM, yyyy',
                          ).format(result);
                          controller.startdateController.text = formattedDate;
                        }
                      },
                      controller: controller.startdateController,
                      hintText: "Date",
                      suffixIcon: TablerIcons.calendar_month,
                      textAlign: TextAlign.center,
                      isReadOnly: true,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextFieldConstant(
                      onTap: () async {
                        DateTime? result = await pickDateTime(
                          context: Get.context!,
                          firstDate: DateTime(DateTime.now().year - 100),

                          initialDate: DateTime.now(),
                          mode: PickerMode.date,
                        );
                        if (result != null) {
                          final formattedDate = DateFormat(
                            'd MMM, yyyy',
                          ).format(result);
                          controller.enddateController.text = formattedDate;
                        }
                      },
                      controller: controller.enddateController,
                      hintText: "Date",
                      suffixIcon: TablerIcons.calendar_month,
                      textAlign: TextAlign.center,
                      isReadOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Center Dropdown
              const TextConstant(title: "Center", fontWeight: FontWeight.w600),
              SizedBox(height: 8.h),
              CustomDropdown<String>(
                items: controller.centers,
                selectedValue: controller.selectedCenter,
                itemLabel: (item) => item,
                hintText: "Select Center",
                prefixIcon: Icons.apartment,
                onChanged: (value) {
                  controller.selectedCenter = value;
                },
              ),
              SizedBox(height: 16.h),

              /// Doctor Dropdown
              const TextConstant(
                title: "Referring Doctor",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              CustomDropdown<String>(
                items: controller.doctors,
                selectedValue: controller.selectedDoctor,
                itemLabel: (item) => item,
                hintText: "Select Doctor",
                prefixIcon: Icons.person,
                onChanged: (value) {
                  controller.selectedDoctor = value;
                },
              ),
              SizedBox(height: 16.h),

              /// Case Status Dropdown
              const TextConstant(
                title: "Case Status",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              CustomDropdown<String>(
                items: controller.caseStatus,
                selectedValue: controller.selectedCaseStatus,
                itemLabel: (item) => item,
                hintText: "Select Case Status",
                prefixIcon: Icons.folder,
                onChanged: (value) {
                  controller.selectedCaseStatus = value;
                },
              ),
              SizedBox(height: 16.h),

              /// Amount Status Dropdown
              const TextConstant(
                title: "Amount Status",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              CustomDropdown<String>(
                items: controller.amountStatus,
                selectedValue: controller.selectedAmountStatus,
                itemLabel: (item) => item,
                hintText: "Select Amount Status",
                prefixIcon: Icons.money,
                onChanged: (value) {
                  controller.selectedAmountStatus = value;
                },
              ),
              SizedBox(height: 20.h),

              /// Action Buttons
              Row(
                children: [
                  Expanded(
                    child: elevatedButton(
                      title: "Reset All",
                      backgroundColor: Color(0xff8B8B8B),
                      textColor: AppColor.whitecolor,
                      onPressed: () {
                        controller.startdateController.clear();
                        controller.enddateController.clear();
                        controller.selectedCenter = null;
                        controller.selectedDoctor = null;
                        controller.selectedCaseStatus = null;
                        controller.selectedAmountStatus = null;
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: elevatedButton(
                      title: "Apply Filters",
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
