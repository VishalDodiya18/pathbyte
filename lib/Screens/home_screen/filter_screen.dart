import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pathbyte/Constants/custom_dropDown.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Constants/textfield_constant.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/widget_constant.dart';
import 'package:pathbyte/Screens/home_screen/controller_home_screen.dart';
import 'package:pathbyte/bottomsheets/common_bottom_sheet.dart';
import 'package:pathbyte/models/doctor_model.dart';
import 'package:pathbyte/models/lab_center_model.dart';
import 'package:pathbyte/utils/app_color.dart';

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
                        final DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          initialDateRange: controller.dates,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          helpText: 'Select Date Range',
                        );

                        if (picked != null && picked != controller.dates) {
                          controller.dates = picked;
                          controller.update();
                        }
                      },
                      controller: TextEditingController(
                        text: controller.dates == null
                            ? ""
                            : "${DateFormat('d MMM, yyyy').format(controller.dates!.start)} -  ${DateFormat('d MMM, yyyy').format(controller.dates!.end)}",
                      ),
                      hintText: "Date Range",
                      suffixIcon: controller.dates == null
                          ? TablerIcons.calendar_month
                          : Icons.clear,
                      suffixOnTap: () => {
                        controller.dates = null,
                        controller.update(),
                        controller.OnRefresh()
                      },
                      textAlign: TextAlign.center,
                      isReadOnly: true,
                    ),
                  ),
                  // SizedBox(width: 12.w),
                  // Expanded(
                  //   child: TextFieldConstant(
                  //     onTap: () async {
                  //       DateTime? result = await pickDateTime(
                  //         context: Get.context!,
                  //         firstDate: DateTime(DateTime.now().year - 100),

                  //         initialDate: DateTime.now(),
                  //         mode: PickerMode.date,
                  //       );
                  //       if (result != null) {
                  //         controller.enddateController.text = result.toString();
                  //         controller.update();
                  //       }
                  //     },
                  //     controller: TextEditingController(
                  //       text: controller.enddateController.text.isEmpty
                  //           ? ""
                  //           : DateFormat('d MMM, yyyy').format(
                  //               DateTime.parse(
                  //                 controller.enddateController.text,
                  //               ),
                  //             ),
                  //     ),
                  //     hintText: "Date",
                  //     suffixIcon: TablerIcons.calendar_month,
                  //     textAlign: TextAlign.center,
                  //     isReadOnly: true,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Center Dropdown
              const TextConstant(title: "Center", fontWeight: FontWeight.w600),
              SizedBox(height: 8.h),
              TextFieldConstant(
                controller: TextEditingController(
                  text: controller.selectedCenter?.name ?? "",
                ),
                hintText: "Select Center",
                isReadOnly: true,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30.0,
                ),
                onTap: () async {
                  final selected = await showModalBottomSheet<Lab>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) {
                      return PaginatedSelectionSheet<Lab>(
                        searchController: controller.labsearch,
                        title: "Center",
                        itemId: (item) => item.id.toString(),
                        controller: controller.labPagingController,
                        itemLabel: (lab) => lab.name ?? "",
                        selectedItem: controller.selectedCenter,
                        onSelect: (lab) {
                          Navigator.pop(context, lab);
                        },
                      );
                    },
                  ).whenComplete(() {
                    controller.labsearch.clear();
                    controller.labPagingController.refresh();
                  });

                  if (selected != null) {
                    controller.selectedCenter = selected;
                    controller.update();
                  }
                },
              ),
              SizedBox(height: 16.h),

              /// Doctor Dropdown
              const TextConstant(
                title: "Referring Doctor",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              TextFieldConstant(
                controller: TextEditingController(
                  text: controller.selectedDoctor == null
                      ? ""
                      : "${controller.selectedDoctor!.firstName} ${controller.selectedDoctor!.lastName}",
                ),
                hintText: "Select Doctor",
                isReadOnly: true,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30.0,
                ),
                onTap: () async {
                  final selected = await showModalBottomSheet<Doctor>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (_) {
                      return PaginatedSelectionSheet<Doctor>(
                        itemId: (item) => item.id.toString(),
                        searchController: controller.doctorsearch,
                        title: "Doctor",
                        controller: controller.doctorPagingController,
                        itemLabel: (doc) => "${doc.firstName} ${doc.lastName}",
                        selectedItem: controller.selectedDoctor,
                        onSelect: (doc) {
                          Navigator.pop(context, doc);
                        },
                      );
                    },
                  ).whenComplete(() {
                    controller.doctorsearch.clear();
                    controller.doctorPagingController.refresh();
                  });

                  if (selected != null) {
                    controller.selectedDoctor = selected;
                    controller.update();
                  }
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
                  controller.update();
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
                  controller.update();
                },
              ),
              SizedBox(height: 20.h),

              /// Action Buttons
              Row(
                children: [
                  Expanded(
                    child: elevatedButton(
                      title: "Reset All",
                      backgroundColor: const Color(0xff8B8B8B),
                      textColor: AppColor.whitecolor,
                      onPressed: () {
                        controller.selectedCenter = null;
                        controller.selectedDoctor = null;
                        controller.selectedCaseStatus = null;
                        controller.selectedAmountStatus = null;
                        Get.back();
                        controller.OnRefresh();
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: elevatedButton(
                      title: "Apply Filters",
                      onPressed: () {
                        Get.back();
                        controller.OnRefresh();
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
