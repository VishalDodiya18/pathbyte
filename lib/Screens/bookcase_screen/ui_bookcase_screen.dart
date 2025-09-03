// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labapp/Constants/custom_dropDown.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/extensions.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/bookcase_screen/bookcase_widget.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:labapp/Screens/bookcase_screen/selected_test_datatable.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/bottomsheets/common_bottom_sheet.dart';
import 'package:labapp/bottomsheets/test_seelction_sheet.dart';
import 'package:labapp/models/caseModel.dart';
import 'package:labapp/models/doctor_model.dart';
import 'package:labapp/models/lab_center_model.dart';
import 'package:labapp/utils/app_color.dart';
import 'package:phone_form_field/phone_form_field.dart';

class BookCaseScreen extends StatelessWidget {
  BookCaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookCaseController>(
      builder: (controller) {
        return PopScope(
          canPop: !controller.isLoading,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text("Add A New Case"),
                  actions: [
                    const Icon(TablerIcons.dots_vertical),
                    widthBox(10),
                  ],
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    spacing: 18.w,
                    children: [
                      Expanded(
                        child: elevatedButton(
                          title: 'Save Case',
                          onPressed: () {
                            if (controller.formkey.currentState!.validate()) {
                              if (controller.selectedGroupTests.isNotEmpty ||
                                  controller.selectedTests.isNotEmpty) {
                                controller.CreateCase();
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Please add atleast one test",
                                  colorText: AppColor.whitecolor,

                                  backgroundColor: AppColor.redcolor,
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                body: Form(
                  key: controller.formkey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              // Expanded(
                              //   child: Column(
                              //     spacing: 10.h,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       const TextConstant(
                              //         title: 'Case ID',
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //       TextFieldConstant(
                              //         controller: controller.caseIdController,
                              //         fillColor: Colors.grey.withValues(alpha: 0.1),
                              //         isReadOnly: true,
                              //         hintText: 'Case ID',
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // widthBox(20),
                              Expanded(
                                child: Column(
                                  spacing: 10.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextConstant(
                                      title: 'Date',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    TextFieldConstant(
                                      controller: TextEditingController(
                                        text: DateFormat("dd, MMM yyyy").format(
                                          DateTime.parse(
                                            controller.dateController.text,
                                          ),
                                        ),
                                      ),
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
                          GetBuilder<HomeController>(
                            builder: (ccontroller) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Doctor Selection
                                  Expanded(
                                    child: Column(
                                      spacing: 10.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TextConstant(
                                          title: 'Referring Doc',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        TextFieldConstant(
                                          controller: TextEditingController(
                                            text:
                                                controller.selectedDoctor ==
                                                    null
                                                ? ""
                                                : "${controller.selectedDoctor!.firstName} ${controller.selectedDoctor!.lastName}",
                                          ),
                                          hintText: "Select Doctor",
                                          isReadOnly: true,
                                          validator: (p0) => p0!.isEmpty
                                              ? "Please select doctor"
                                              : null,
                                          maxLines: 5,
                                          minLines: 1,
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 30.0,
                                          ),
                                          onTap: () async {
                                            final selected =
                                                await showModalBottomSheet<Doctor>(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.white,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            20,
                                                          ),
                                                        ),
                                                  ),
                                                  builder: (_) {
                                                    return PaginatedSelectionSheet<
                                                      Doctor
                                                    >(
                                                      title: "Doctor",
                                                      itemId: (item) =>
                                                          item.id.toString(),
                                                      searchController:
                                                          ccontroller
                                                              .doctorsearch,
                                                      controller: ccontroller
                                                          .doctorPagingController,
                                                      itemLabel: (d) =>
                                                          "${d.firstName} ${d.lastName}",
                                                      selectedItem: controller
                                                          .selectedDoctor,
                                                      onSelect: (d) {
                                                        Navigator.pop(
                                                          context,
                                                          d,
                                                        );
                                                        ccontroller.update();
                                                      },
                                                    );
                                                  },
                                                ).whenComplete(() {
                                                  ccontroller.doctorsearch
                                                      .clear();
                                                  ccontroller
                                                      .doctorPagingController
                                                      .refresh();
                                                });

                                            if (selected != null) {
                                              controller.selectedDoctor =
                                                  selected;
                                              controller.update();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  widthBox(20),
                                  // Center Selection
                                  Expanded(
                                    child: Column(
                                      spacing: 10.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TextConstant(
                                          title: 'Center*',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        TextFieldConstant(
                                          controller: TextEditingController(
                                            text:
                                                controller
                                                    .selectedCenter
                                                    ?.name ??
                                                "",
                                          ),
                                          maxLines: 5,
                                          minLines: 1,
                                          hintText: "Select Center",
                                          isReadOnly: true,
                                          validator: (p0) => p0!.isEmpty
                                              ? "Please select center"
                                              : null,
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 30.0,
                                          ),
                                          onTap: () async {
                                            final selected =
                                                await showModalBottomSheet<Lab>(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  backgroundColor: Colors.white,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            20,
                                                          ),
                                                        ),
                                                  ),

                                                  builder: (_) {
                                                    return PaginatedSelectionSheet<
                                                      Lab
                                                    >(
                                                      searchController:
                                                          ccontroller.labsearch,
                                                      itemId: (item) =>
                                                          item.id.toString(),
                                                      title: "Center",
                                                      controller: ccontroller
                                                          .labPagingController,
                                                      itemLabel: (lab) =>
                                                          lab.name ?? "",
                                                      selectedItem: controller
                                                          .selectedCenter,
                                                      onSelect: (lab) {
                                                        Navigator.pop(
                                                          context,
                                                          lab,
                                                        );
                                                        ccontroller.update();
                                                      },
                                                    );
                                                  },
                                                ).whenComplete(() {
                                                  ccontroller.labsearch.clear();
                                                  ccontroller
                                                      .labPagingController
                                                      .refresh();
                                                });

                                            if (selected != null) {
                                              controller.selectedCenter =
                                                  selected;
                                              controller.update();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          heightBox(15),
                          const Divider(),
                          heightBox(10),
                          Row(
                            children: [
                              Expanded(
                                child: const TextConstant(
                                  title: 'Patient Details',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              GetBuilder<BookCaseController>(
                                builder: (cc) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cc.selectedpatient == null
                                          ? AppColor.greencolor
                                          : AppColor.primary,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      cc.selectedpatient == null
                                          ? "New Patient"
                                          : "Existing Patient",
                                      style: TextStyle(
                                        color: AppColor.whitecolor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          heightBox(15),
                          const TextConstant(
                            title: 'Phone Number*',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(12),
                          GetBuilder<HomeController>(
                            builder: (homecontroller) {
                              return PhoneFormField(
                                controller: controller.phoneNumber,
                                validator: PhoneValidator.compose([
                                  PhoneValidator.required(
                                    context,
                                    errorText: "You must enter a value",
                                  ),
                                  PhoneValidator.validMobile(
                                    context,
                                    errorText: "Enter a valid phone number",
                                  ),
                                ]),
                                onChanged: (p0) {
                                  controller.selectedpatient = null;
                                  controller.update();
                                },
                                countrySelectorNavigator:
                                    CountrySelectorNavigator.draggableBottomSheet(
                                      flagSize: 30,
                                      searchBoxTextStyle: textStyle(
                                        fontSize: 16,
                                      ),
                                      titleStyle: textStyle(fontSize: 16),
                                      sortCountries: true,
                                      subtitleStyle: textStyle(fontSize: 16),
                                      showDialCode: false,
                                    ),

                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,

                                isCountrySelectionEnabled: true,
                                isCountryButtonPersistent: true,
                                countryButtonStyle: CountryButtonStyle(
                                  showDialCode: true,
                                  textStyle: textStyle(fontSize: 16),
                                  showIsoCode: false,

                                  showFlag: false,
                                  flagSize: 16,
                                ),
                                decoration: buildInputDecoration(
                                  context: context,
                                  hintText: "Phone Number",
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      final selected =
                                          await showModalBottomSheet<Patient>(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.white,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                            ),
                                            builder: (_) {
                                              return PaginatedSelectionSheet<
                                                Patient
                                              >(
                                                title: "Patient",
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                controller: homecontroller
                                                    .patientPagingController,
                                                itemId: (item) =>
                                                    item.sId ?? "",
                                                itemLabel: (item) =>
                                                    "${item.phoneNumbers?.first}\n${item.firstName} ${item.lastName} (${item.patientId})",
                                                selectedItem:
                                                    controller.selectedpatient,
                                                searchController: homecontroller
                                                    .patientSearchController,

                                                onSelect: (patient) {
                                                  Navigator.pop(
                                                    context,
                                                    patient,
                                                  );
                                                },
                                              );
                                            },
                                          ).whenComplete(() {
                                            homecontroller
                                                .patientSearchController
                                                .clear();
                                            homecontroller
                                                .patientPagingController
                                                .refresh();
                                          });

                                      if (selected != null) {
                                        controller.selectedpatient = selected;
                                        controller.phoneNumber.value =
                                            PhoneNumber(
                                              isoCode: IsoCode.IN,
                                              nsn: (selected.phoneNumbers ?? [])
                                                  .first
                                                  .replaceAll("+", "")
                                                  .replaceAll(" ", ""),
                                            );
                                        controller.nameController.text =
                                            "${selected.firstName ?? ""} ${selected.lastName ?? ""}";
                                        controller.emailController.text =
                                            selected.email ?? "";
                                        controller.selectedSex.value =
                                            (selected.gender ?? "")
                                                .capitalize ??
                                            "Male";
                                        controller.selectedSex.value =
                                            (selected.gender ?? "")
                                                .capitalize ??
                                            "Male";
                                        if (selected.address != null) {
                                          controller.address.text =
                                              selected.address?.line1 ?? "";
                                          controller.address2.text =
                                              selected.address?.line2 ?? "";
                                          controller.city.text =
                                              selected.address?.city ?? "";
                                          controller.state.text =
                                              selected.address?.state ?? "";
                                          controller.pincode.text =
                                              selected.address?.postalCode ??
                                              "";
                                        }
                                        controller.yearsController.text =
                                            (selected.age ?? 18).toString();
                                        controller.update();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          heightBox(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  spacing: 10.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextConstant(
                                      title: 'Title',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Obx(() {
                                      controller.selectedTitle.value;
                                      return CustomDropdown<String>(
                                        dropdownHeight: 300.h,
                                        items: controller.mrmissList,
                                        prefixIcon: TablerIcons.chevron_down,
                                        selectedValue:
                                            controller.selectedTitle.value,
                                        itemLabel: (val) => val,
                                        hintText: "Select Title",
                                        onChanged: (value) {
                                          controller.selectedTitle.value =
                                              value!;
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
                                    const TextConstant(
                                      title: 'Name',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    TextFieldConstant(
                                      controller: controller.nameController,
                                      hintText: 'Name',
                                      validator: (p0) => p0!.isEmpty
                                          ? "Please enter name"
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          heightBox(15),
                          const TextConstant(
                            title: 'Email*',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(12),
                          TextFieldConstant(
                            controller: controller.emailController,
                            hintText: "Enter your email",
                            keyboardType: TextInputType.emailAddress,
                            // validator: TextValidations().validateEmail,
                            onChanged: (val) {
                              debugPrint("Email typed: $val");
                            },
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
                                    const TextConstant(
                                      title: 'Sex',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Obx(() {
                                      controller.selectedSex.value;
                                      return CustomDropdown<String>(
                                        dropdownHeight: 300.h,
                                        items: controller.sexList,
                                        prefixIcon: TablerIcons.chevron_down,
                                        selectedValue:
                                            controller.selectedSex.value,
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
                                    const TextConstant(
                                      title: 'Age',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                          const TextConstant(
                            title: 'Address',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          TextFieldConstant(
                            controller: controller.address,
                            hintText: 'Address',
                            // validator: (p0) =>
                            //     p0!.isEmpty ? "Please enter address" : null,
                          ),

                          // heightBox(15),
                          // const TextConstant(
                          //   title: 'Address Line 2',
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w500,
                          // ),
                          // heightBox(8),
                          // TextFieldConstant(
                          //   controller: controller.address2,
                          //   hintText: 'Address Line 2',
                          // ),
                          // heightBox(15),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const TextConstant(
                          //             title: 'State',
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //           heightBox(8),
                          //           TextFieldConstant(
                          //             controller: controller.state,
                          //             hintText: 'State',
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     widthBox(15),
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const TextConstant(
                          //             title: 'City',
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //           heightBox(8),
                          //           TextFieldConstant(
                          //             controller: controller.city,
                          //             hintText: 'City',
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // heightBox(15),
                          // const TextConstant(
                          //   title: 'Pincode',
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w500,
                          // ),
                          // heightBox(8),
                          // TextFieldConstant(
                          //   controller: controller.pincode,
                          //   hintText: 'Pincode',
                          //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          //   keyboardType: TextInputType.number,
                          // ),
                          heightBox(20),

                          const TextConstant(
                            title: 'Test Details',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          heightBox(18),
                          SelectedTestsTable(),
                          heightBox(20),
                          GestureDetector(
                            onTap: () {
                              showTestBottomSheet(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextConstant(
                                title: '+ Add New Test',
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(color: AppColor.secondarycolor),
                          heightBox(10),

                          const TextConstant(
                            title: 'Payment Details',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          heightBox(18),
                          Column(
                            spacing: 10.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextConstant(
                                title: 'Mode',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              Obx(() {
                                controller.selectedMode.value;
                                return Row(
                                  children: [
                                    Radio(
                                      value: "Cash",
                                      groupValue: controller.selectedMode.value,
                                      onChanged: (value) {
                                        controller.selectedMode.value = value!;
                                      },
                                    ),
                                    Text("Cash"),
                                    Radio(
                                      value: "UPI",
                                      groupValue: controller.selectedMode.value,
                                      onChanged: (value) {
                                        controller.selectedMode.value = value!;
                                      },
                                    ),
                                    Text("UPI"),
                                  ],
                                );
                              }),
                            ],
                          ),
                          heightBox(15),
                          const TextConstant(
                            title: 'Discount',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          GetBuilder<BookCaseController>(
                            builder: (contrller) {
                              return TextFieldConstant(
                                controller: controller.discount,
                                hintText: 'Discount',

                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                  MaxValueInputFormatter(
                                    controller.gettotalamount(),
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (p0) {
                                  controller.recivedamount.clear();
                                  controller.update();
                                },
                              );
                            },
                          ),
                          heightBox(15),
                          const TextConstant(
                            title: 'Amount Received',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          GetBuilder<BookCaseController>(
                            builder: (contrller) {
                              return TextFieldConstant(
                                controller: controller.recivedamount,
                                hintText: 'Amount Received',
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                  MaxValueInputFormatter(
                                    controller.gettotalwitdiscountamount(),
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (p0) {
                                  controller.update();
                                },
                              );
                            },
                          ),

                          heightBox(25),
                          GetBuilder<BookCaseController>(
                            builder: (bcontroller) {
                              return Column(
                                children: [
                                  buildRow(
                                    'Sub Total',
                                    formatIndianCurrency(
                                      controller.gettotalamount(),
                                    ),
                                    false,
                                  ),

                                  buildRow(
                                    'Discount',
                                    bcontroller.discount.text.isEmpty
                                        ? "0"
                                        : bcontroller.discount.text,
                                    false,
                                  ),
                                  buildRow(
                                    'Total',
                                    formatIndianCurrency(
                                      controller.gettotalwitdiscountamount(),
                                    ),
                                    false,
                                  ),
                                  buildRow(
                                    'Amount Received',
                                    formatIndianCurrency(
                                      controller
                                          .gettotalwitdiscountwithrecivedamount(),
                                    ),
                                    false,
                                  ),
                                  buildRow(
                                    'Balance',

                                    formatIndianCurrency(
                                      controller.getfinalamount(),
                                    ),
                                    true,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black45,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.whitecolor,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
