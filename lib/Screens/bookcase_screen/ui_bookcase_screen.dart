import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labapp/Constants/custom_dropDown.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/bookcase_screen/bookcase_widget.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:phone_form_field/phone_form_field.dart';

class BookCaseScreen extends StatelessWidget {
  BookCaseScreen({super.key});

  final BookCaseController controller = Get.put(BookCaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, actions: [const Icon(TablerIcons.dots_vertical), widthBox(10)]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          spacing: 18.w,
          children: [
            Expanded(
              child: elevatedButton(title: 'Save Case', onPressed: () {}),
            ),
            Expanded(
              child: elevatedButton(title: 'Save & Print', onPressed: () {}),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextConstant(title: 'Add A New Case', fontSize: 16, fontWeight: FontWeight.bold),
              heightBox(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConstant(title: 'Case ID', fontSize: 16, fontWeight: FontWeight.w500),
                        TextFieldConstant(
                          controller: controller.caseIdController,
                          fillColor: Colors.grey.withValues(alpha: 0.1),
                          isReadOnly: true,
                          hintText: 'Case ID',
                        ),
                      ],
                    ),
                  ),
                  widthBox(100),
                  Expanded(
                    flex: 3,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextConstant(title: 'Date', fontSize: 16, fontWeight: FontWeight.w500),
                        TextFieldConstant(
                          onTap: () async {
                            DateTime? result = await pickDateTime(
                              context: Get.context!,
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              mode: PickerMode.date,
                            );
                            if (result != null) {
                              final formattedDate = DateFormat('d MMM, yyyy').format(result);
                              controller.dateController.text = formattedDate;
                            }
                          },
                          controller: controller.dateController,
                          hintText: "Date",
                          suffixIcon: TablerIcons.calendar_month,
                          textAlign: TextAlign.center,
                          isReadOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              heightBox(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConstant(title: 'Referring Doc', fontSize: 16, fontWeight: FontWeight.w500),
                        Obx(() {
                          controller.selectedReferringDoc.value;
                          return CustomDropdown<String>(
                            dropdownHeight: 300.h,
                            items: controller.referreingDocList,
                            prefixIcon: TablerIcons.chevron_down,
                            selectedValue: controller.selectedReferringDoc.value,
                            itemLabel: (val) => val,
                            hintText: "Select Referring Doctor",
                            onChanged: (value) {
                              controller.selectedReferringDoc.value = value!;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  widthBox(20),
                  Expanded(
                    flex: 4,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextConstant(title: 'Center', fontSize: 16, fontWeight: FontWeight.w500),
                        Obx(() {
                          controller.selectedCenter.value;
                          return CustomDropdown<String>(
                            dropdownHeight: 300.h,
                            items: controller.centerList,
                            prefixIcon: TablerIcons.chevron_down,
                            selectedValue: controller.selectedCenter.value,
                            itemLabel: (val) => val,
                            hintText: "Select Center",
                            onChanged: (value) {
                              controller.selectedCenter.value = value!;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              heightBox(15),
              Divider(),
              heightBox(10),
              TextConstant(title: 'Patient Details', fontWeight: FontWeight.bold, fontSize: 16),
              heightBox(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConstant(title: 'Title', fontSize: 16, fontWeight: FontWeight.w500),
                        Obx(() {
                          controller.selectedTitle.value;
                          return CustomDropdown<String>(
                            dropdownHeight: 300.h,
                            items: controller.mrmissList,
                            prefixIcon: TablerIcons.chevron_down,
                            selectedValue: controller.selectedTitle.value,
                            itemLabel: (val) => val,
                            hintText: "Select Title",
                            onChanged: (value) {
                              controller.selectedTitle.value = value!;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  widthBox(20),
                  Expanded(
                    flex: 4,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConstant(title: 'Name', fontSize: 16, fontWeight: FontWeight.w500),
                        TextFieldConstant(controller: controller.nameController, hintText: 'Name'),
                      ],
                    ),
                  ),
                ],
              ),
              heightBox(12),
              PhoneFormField(
                initialValue: controller.phoneNumber.value,
                validator: PhoneValidator.compose([
                  PhoneValidator.required(context, errorText: "You must enter a value"),
                  PhoneValidator.validMobile(context, errorText: "Enter a valid phone number"),
                ]),
                countrySelectorNavigator: CountrySelectorNavigator.draggableBottomSheet(
                  flagSize: 30,
                  searchBoxTextStyle: textStyle(fontSize: 16),
                  titleStyle: textStyle(fontSize: 16),
                  sortCountries: true,
                  subtitleStyle: textStyle(fontSize: 16),
                  showDialCode: false,
                ),

                autovalidateMode: AutovalidateMode.onUnfocus,
                onChanged: (phoneNumber) => controller.updatePhone(phoneNumber),
                enabled: true,
                isCountrySelectionEnabled: true,
                isCountryButtonPersistent: true,
                countryButtonStyle: CountryButtonStyle(
                  showDialCode: true,
                  textStyle: textStyle(fontSize: 16),
                  showIsoCode: false,
                  showFlag: false,
                  flagSize: 16,
                ),
                decoration: buildInputDecoration(context: context, hintText: "Phone Number"),
              ),
              heightBox(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextConstant(title: 'Sex', fontSize: 16, fontWeight: FontWeight.w500),
                        Obx(() {
                          controller.selectedSex.value;
                          return CustomDropdown<String>(
                            dropdownHeight: 300.h,
                            items: controller.sexList,
                            prefixIcon: TablerIcons.chevron_down,
                            selectedValue: controller.selectedSex.value,
                            itemLabel: (val) => val,
                            hintText: "Select Sex",
                            onChanged: (value) {
                              controller.selectedSex.value = value!;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  widthBox(20),
                  Expanded(
                    flex: 4,
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextConstant(title: 'Age', fontSize: 16, fontWeight: FontWeight.w500),
                        YMDInput(
                          yearsCtrl: controller.yearsController,
                          monthsCtrl: controller.monthsController,
                          daysCtrl: controller.daysController,
                          onChanged: ({years, months, days}) {
                            // optional: keep a combined string, duration, etc.
                            // controller.ymdString.value = '${years ?? 0}Y ${months ?? 0}M ${days ?? 0}D';
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              heightBox(15),
              TextConstant(title: 'Address', fontSize: 16, fontWeight: FontWeight.w500),
              heightBox(8),
              TextFieldConstant(controller: controller.addressController, hintText: 'Address'),
              heightBox(80),
              TextButton(
                onPressed: () {},
                child: TextConstant(title: '+ Add New Test', color: Color(0xFF2E37A4), fontWeight: FontWeight.bold),
              ),
              Divider(),
              TextConstant(title: 'Payment Details', fontSize: 16, fontWeight: FontWeight.bold),
              heightBox(12),
              Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextConstant(title: 'Mode', fontSize: 16, fontWeight: FontWeight.w500),
                  Obx(() {
                    controller.selectedMode.value;
                    return SizedBox(
                      width: 120.w,
                      child: CustomDropdown<String>(
                        dropdownHeight: 300.h,
                        items: controller.modeList,
                        prefixIcon: TablerIcons.chevron_down,
                        selectedValue: controller.selectedMode.value,
                        itemLabel: (val) => val,
                        hintText: "Select Mode",
                        onChanged: (value) {
                          controller.selectedMode.value = value!;
                        },
                      ),
                    );
                  }),
                ],
              ),
              heightBox(80),
              elevatedButton(title: 'Cancel', backgroundColor: Colors.black.withValues(alpha: 0.7), onPressed: () {}),
              heightBox(15),
              Column(
                children: [
                  buildRow('Total', '1700', false),
                  buildDivider(),
                  buildRow('Discount', '0', false),
                  buildDivider(),
                  buildRow('Amount Received', '1000', false),
                  buildRow('Balance', '700', true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
