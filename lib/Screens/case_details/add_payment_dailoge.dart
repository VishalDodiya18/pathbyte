import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/textfield_constant.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/Screens/home_screen/controller_home_screen.dart';
import 'package:pathbyte/helper/helpers.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';

class AddPaymentDialog extends StatefulWidget {
  var caseid;
  int maxvalue;
  AddPaymentDialog({super.key, required this.maxvalue, required this.caseid});

  @override
  State<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  TextEditingController amountController = TextEditingController();
  String selectedMode = "Cash"; // default
  bool isLoading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  CreateTransaction(caseid) async {
    isLoading = true;
    setState(() {});

    try {
      final url = Uri.parse("${AppConfig.baseUrl}/transactions");

      final body = {
        "caseId": caseid,
        "amountGiven": int.parse(
          amountController.text.isEmpty ? "0" : amountController.text,
        ),
        "mode": selectedMode.toLowerCase(),
      };

      print(body.toString());
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConfig.Token}",
        },
        body: jsonEncode(body),
      );

      var model = jsonDecode(response.body);
      if (response.statusCode == 500) {
        Logout(message: model["message"] ?? "Your Session is expired");
        return;
      }
      if (response.statusCode == 201 && model["code"] == 201) {
        Get.back();
        Get.find<CaseDetailsContoller>().fetchCaseById();
        Get.find<HomeController>().OnRefresh();
      } else {
        Get.snackbar(
          "Error",
          model["message"] ?? "Case Creation failed please try again",
          colorText: AppColor.whitecolor,

          backgroundColor: AppColor.redcolor,
        );
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: F,
      child: IgnorePointer(
        ignoring: isLoading,
        child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Payment",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.clear),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Amount TextField
              Form(
                key: formkey,
                child: TextFieldConstant(
                  controller: amountController,
                  hintText: 'Enter Received Amount',
                  validator: (p0) => p0!.isEmpty
                      ? "Enter Amount"
                      : int.parse(p0) == 0
                      ? "Please enter valid amount"
                      : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                    MaxValueInputFormatter(widget.maxvalue),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    // controller.update();
                  },
                ),
              ),

              const SizedBox(height: 15),

              // Radio Buttons
              const Text(
                "Mode",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Cash",
                    groupValue: selectedMode,
                    onChanged: (value) {
                      setState(() {
                        selectedMode = value!;
                      });
                    },
                  ),
                  const Text("Cash"),
                  Radio<String>(
                    value: "UPI",
                    groupValue: selectedMode,
                    onChanged: (value) {
                      setState(() {
                        selectedMode = value!;
                      });
                    },
                  ),
                  const Text("UPI"),
                ],
              ),

              const SizedBox(height: 15),

              // Buttons
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      spacing: 15.0,
                      children: [
                        Flexible(
                          child: elevatedButton(
                            title: "Cancel",
                            onPressed: () {
                              Get.back();
                            },
                            backgroundColor: AppColor.greycolor.withOpacity(
                              0.8,
                            ),
                          ),
                        ),
                        Flexible(
                          child: elevatedButton(
                            title: "Add",
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                CreateTransaction(widget.caseid);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
