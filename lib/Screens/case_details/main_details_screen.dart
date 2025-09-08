// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen_edit.dart';
import 'package:labapp/Screens/bookcase_screen/ui_bookcase_screen_edit.dart';
import 'package:labapp/Screens/case_details/case_details.dart';
import 'package:labapp/Screens/case_details/controller_case_details_screen.dart';
import 'package:labapp/Screens/case_details/report_details.dart';
import 'package:labapp/models/case_details_model.dart';
import 'package:labapp/utils/app_color.dart';

class MainDetailsScreen extends StatelessWidget {
  bool isreport;
  MainDetailsScreen({super.key, this.isreport = false});

  @override
  Widget build(BuildContext context) {
    final CaseDetailsContoller controller = Get.find<CaseDetailsContoller>();

    return Scaffold(
      appBar: AppBar(
        title: Text(isreport ? "Report Details" : 'Case Details'),
        actions: isreport
            ? []
            : [
                PopupMenuButton(
                  offset: Offset(-15, 25),
                  onSelected: (value) {
                    if (value == "edit") {
                      Get.lazyPut(
                        () => EditBookCaseController(
                          caseDetails: controller.caseDetails ?? CaseDetails(),
                        ),
                      );
                      Get.to(() => EditBookCaseScreen());
                    }
                  },

                  child: Icon(Icons.more_vert),
                  color: AppColor.whitecolor,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: "edit",
                        height: 30.0,
                        child: Text("Edit"),
                      ),
                    ];
                  },
                ),
                SizedBox(width: 10.0),
              ],
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : isreport
            ? ReportDetails()
            : CaseDetailsPage();
      }),
    );
  }
}
