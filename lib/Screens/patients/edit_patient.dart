import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:labapp/Constants/custom_dropDown.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/extensions.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/textfield_constant.dart'
    hide UpperCaseTextFormatter;
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/bookcase_screen/bookcase_widget.dart';
import 'package:labapp/Screens/patients/patient_controller.dart';
import 'package:labapp/Screens/patients/patient_details_controller.dart';
import 'package:labapp/models/caseModel.dart';
import 'package:labapp/utils/app_color.dart';
import 'package:labapp/utils/app_config.dart';
import 'package:phone_form_field/phone_form_field.dart';

class PatientDialog extends StatefulWidget {
  final Patient patient;
  const PatientDialog({super.key, required this.patient});

  @override
  State<PatientDialog> createState() => _PatientDialogState();
}

class _PatientDialogState extends State<PatientDialog> {
  // Controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController yearsController;
  late TextEditingController monthsController;
  late TextEditingController daysController;
  late PhoneController phoneNumber;

  // Dropdown lists
  final List<String> mrmissList = [
    'Mr.', 'Mrs.', 'Ms.',

    // , 'Dr.'
  ];
  final List<String> sexList = ['Male', 'Female', 'Other'];

  // Selected values
  String? selectedTitle;
  String? selectedSex;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Prefill controllers with patient data
    nameController = TextEditingController(
      text:
          "${widget.patient.firstName ?? ""} ${widget.patient.lastName ?? ""}",
    );
    emailController = TextEditingController(text: widget.patient.email ?? "");
    addressController = TextEditingController(
      text: widget.patient.address?.line1 ?? "",
    );

    yearsController = TextEditingController(
      text: (widget.patient.age ?? "").toString(),
    );
    monthsController = TextEditingController(
      text: widget.patient.months.toString(),
    );
    daysController = TextEditingController(
      text: widget.patient.days.toString(),
    );

    phoneNumber = PhoneController(
      initialValue: PhoneNumber(
        isoCode: IsoCode.IN,
        nsn: (widget.patient.phoneNumbers ?? []).isNotEmpty
            ? widget.patient.phoneNumbers!.first
                  .replaceAll("+", "")
                  .trim()
                  .split(" ")
                  .last
            : "",
      ),
    );

    // Dropdown prefill
    selectedSex = widget.patient.gender;
    // Agar title ka data model me nahi hai to default Mr.
    selectedTitle = mrmissList.contains(widget.patient.title)
        ? widget.patient.title
        : mrmissList.first;
  }

  updatePatient(Patient patient) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse("${AppConfig.baseUrl}/patients/${patient.sId}");
    log(
      getDobFromAge(
        int.parse(yearsController.text),
        int.parse(monthsController.text),
        int.parse(daysController.text),
        format: "yyyy-MM-dd",
      ).toString(),
    );
    final body = {
      "firstName": nameController.text,
      "lastName": "",
      "age": int.parse(yearsController.text),
      "months": int.parse(monthsController.text),
      "days": int.parse(daysController.text),
      "gender": selectedSex,
      "phoneNumbers": [
        "+${phoneNumber.value.countryCode} ${phoneNumber.value.nsn}",
      ],
      // "dob": getDobFromAge(
      //   int.parse(yearsController.text),
      //   int.parse(monthsController.text),
      //   int.parse(daysController.text),
      //   format: "yyyy-MM-dd",
      // ),
      if (emailController.text.isNotEmpty) "email": emailController.text,
      "title": selectedTitle,
      "address": {
        "line1": addressController.text,
        //  getFullAddress(
        //   Address.fromJson({
        //     "line1": address.text,
        //     "line2": address2.text,
        //     "city": city.text,
        //     "state": state.text,
        //     "postalCode": pincode.text,
        //     "country": "India",
        //   }),
        // ),
        "line2": "",
        "city": "",
        "state": "",
        "postalCode": "",
        "country": "",
      },
    };

    try {
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      var model = jsonDecode(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200 && model["code"] == 200) {
        Get.back();

        Get.find<PatientDetailsController>().fetchpatient();
        Get.find<PatientController>().patientPagingController.refresh();
      } else {
        log(model["message"]);
        Get.snackbar(
          "Error",
          model["message"] ?? "Patient updation failed please try again",
          colorText: AppColor.whitecolor,

          backgroundColor: AppColor.redcolor,
        );
        print("⚠️ Failed to update patient: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        "Error",
        e.toString() ?? "Patient updation failed please try again",
        colorText: AppColor.whitecolor,

        backgroundColor: AppColor.redcolor,
      );
      print("❌ Error updating patient: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    yearsController.dispose();
    monthsController.dispose();
    daysController.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: F,

      child: IgnorePointer(
        ignoring: isLoading,
        child: Dialog(
          backgroundColor: AppColor.whitecolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: ListView(
              shrinkWrap: T,
              padding: const EdgeInsets.all(20),

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Patient Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.clear),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Phone Number
                PhoneFormField(
                  controller: phoneNumber,
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
                  onChanged: (p0) {},
                  countrySelectorNavigator:
                      CountrySelectorNavigator.draggableBottomSheet(
                        flagSize: 30,
                        searchBoxTextStyle: textStyle(fontSize: 16),
                        titleStyle: textStyle(fontSize: 16),
                        sortCountries: true,
                        subtitleStyle: textStyle(fontSize: 16),
                        showDialCode: false,
                      ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration(
                    context: context,
                    hintText: "Enter phone number",
                  ),
                  isCountrySelectionEnabled: F,
                  isCountryButtonPersistent: true,

                  countryButtonStyle: CountryButtonStyle(
                    showDialCode: true,
                    textStyle: textStyle(fontSize: 16),
                    showIsoCode: false,
                    showFlag: false,
                    showDropdownIcon: F,
                    flagSize: 16,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextConstant(
                            title: 'Title',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          CustomDropdown<String>(
                            dropdownHeight: 300.h,
                            items: mrmissList,
                            prefixIcon: TablerIcons.chevron_down,
                            selectedValue: selectedTitle,
                            itemLabel: (val) => val,
                            hintText: "Title",
                            onChanged: (value) {
                              setState(() {
                                selectedTitle = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    widthBox(20),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextConstant(
                            title: 'Name',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          TextFieldConstant(
                            controller: nameController,
                            hintText: 'Enter your name',
                            inputFormatters: [UpperCaseTextFormatter()],
                            validator: (p0) =>
                                p0!.isEmpty ? "Please enter name" : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                heightBox(15),
                // Email
                const TextConstant(
                  title: 'Email',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                heightBox(12),
                TextFieldConstant(
                  controller: emailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                ),

                heightBox(15),
                // Sex + Age
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextConstant(
                            title: 'Sex',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          CustomDropdown<String>(
                            dropdownHeight: 300.h,
                            items: sexList,
                            prefixIcon: TablerIcons.chevron_down,
                            selectedValue: selectedSex,
                            itemLabel: (val) => val,
                            hintText: "Select Sex",
                            onChanged: (value) {
                              setState(() {
                                selectedSex = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    widthBox(20),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextConstant(
                            title: 'Age',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          heightBox(8),
                          YMDInput(
                            yearsCtrl: yearsController,
                            monthsCtrl: monthsController,
                            daysCtrl: daysController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                heightBox(15),
                // Address
                const TextConstant(
                  title: 'Address',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                heightBox(8),
                TextFieldConstant(
                  controller: addressController,
                  hintText: 'Enter your address',
                ),

                heightBox(20),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : elevatedButton(
                        title: "Save",

                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            updatePatient(widget.patient);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Show dialog method
Future<void> showPatientDialog(BuildContext context, Patient patient) {
  return showDialog(
    context: context,
    builder: (_) => PatientDialog(patient: patient),
  );
}
