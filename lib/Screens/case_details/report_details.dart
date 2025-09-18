import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Constants/widget_constant.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/Screens/case_details/report_table.dart';
import 'package:pathbyte/utils/app_color.dart';

class ReportDetails extends StatelessWidget {
  ReportDetails({super.key});
  final CaseDetailsContoller controller = Get.find<CaseDetailsContoller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.reporting.value || controller.isreportshareing.value
          ? const Center(child: CircularProgressIndicator())
          : controller.reporting.isFalse &&
                controller.reportDetailsModel == null
          ? Center(
              child: Text(
                "Report Detail Not Found",
                style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColor.bordercolor),
                          ),
                          child: Column(
                            spacing: 5.0,
                            children: [
                              buildReportRow(
                                title: "Case ID :",
                                value:
                                    "#${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.caseId ?? ""}",
                              ),
                              buildReportRow(
                                title: "Patient ID :",
                                value:
                                    "(#${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.patientId})",
                              ),
                              buildReportRow(
                                title: "Patient Name :",
                                value:
                                    controller
                                        .reportDetailsModel
                                        ?.data
                                        ?.reportdetail
                                        ?.caseDetails
                                        ?.patient
                                        ?.firstName ??
                                    "",
                              ),
                              buildReportRow(
                                title: "Age/ Sex :",
                                value:
                                    "${(controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.age ?? 0) != 0
                                        ? controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.age ?? 0
                                        : (controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.months ?? 0) != 0
                                        ? controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.months ?? 0
                                        : controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.days ?? 0}/ ${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.gender}",
                              ),
                              buildReportRow(
                                title: "Referred By :",
                                value:
                                    controller
                                        .reportDetailsModel
                                        ?.data
                                        ?.reportdetail
                                        ?.caseDetails
                                        ?.doctor
                                        ?.firstName ??
                                    "",
                              ),
                              // buildReportRow(
                              //   title: "Registration Time :",
                              //   value: DateFormat("dd MMMM ,yyyy").format(
                              //     controller
                              //             .reportDetailsModel
                              //             ?.data
                              //             ?.reportdetail
                              //             ?.caseDetails
                              //             ?.createdAt ??
                              //         DateTime.now(),
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        heightBox(10),
                        ListView.separated(
                          shrinkWrap: T,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              (controller
                                          .reportDetailsModel
                                          ?.data
                                          ?.reportdetail
                                          ?.categories ??
                                      [])
                                  .length,
                          separatorBuilder: (context, index) => heightBox(15),
                          itemBuilder: (context, i) {
                            return ReportTable(
                              category:
                                  (controller
                                      .reportDetailsModel
                                      ?.data
                                      ?.reportdetail
                                      ?.categories ??
                                  [])[i],
                              isfinal: F,
                              // isfinal:
                              //     (controller
                              //             .reportDetailsModel
                              //             ?.data
                              //             ?.reportdetail
                              //             ?.caseDetails
                              //             ?.status ??
                              //         "") ==
                              //     "Final",
                            );
                          },
                        ),
                        heightBox(100),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller
                              .reportDetailsModel
                              ?.data
                              ?.reportdetail
                              ?.caseDetails
                              ?.status !=
                          "Final")
                        Row(
                          spacing: 10.0.w,
                          children: [
                            Expanded(
                              child: elevatedButton(
                                title: "Save as Draft",
                                onPressed: () {
                                  controller.CreateReportResult();
                                },
                              ),
                            ),
                            if (controller
                                        .reportDetailsModel
                                        ?.data
                                        ?.reportdetail
                                        ?.caseDetails
                                        ?.status ==
                                    "InProgress" ||
                                controller
                                        .reportDetailsModel
                                        ?.data
                                        ?.reportdetail
                                        ?.caseDetails
                                        ?.status ==
                                    "New")
                              Expanded(
                                child: elevatedButton(
                                  title: "Save As Final",
                                  onPressed: () {
                                    controller.CreateReportResult(isdraft: F);
                                  },
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(height: 15.0),
                      Column(
                        children: [
                          Row(
                            spacing: 20.0,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Print Footnote",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Obx(
                                () => Switch(
                                  value: controller.printFootnote.value,
                                  activeColor: AppColor.primary,

                                  onChanged: (value) {
                                    controller.printFootnote.value = value;
                                  },
                                ),
                              ),
                              Obx(
                                () => Text(
                                  controller.printFootnote.value ? "Yes" : "No",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          elevatedButton(
                            title: "Share Report",
                            onPressed: () {
                              controller.downloadAndSharePdf();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

Widget buildReportRow({
  required String title,
  required String value,
  double fontSize = 15,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: TextConstant(
          title: title,
          textAlign: TextAlign.start,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(
        child: TextConstant(
          title: value,
          textAlign: TextAlign.end,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Discard(context) {
  var height = MediaQuery.of(context).size.height;
  return showDialog(
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: StatefulBuilder(
        builder: (context, set) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primary, width: 1.5),
                    color: const Color(0XFFFDEFE0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: height * 0.018),
                      Text(
                        "Discard",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                          fontSize: height * 0.022,
                        ),
                      ),
                      SizedBox(height: height * 0.008),
                      Text(
                        "are you sure want to discard your changes?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: height * 0.018,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      elevatedButton(
                        onPressed: () {
                          Get.back();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Get.back();
                          });
                        },
                        title: "Yes",
                      ),
                      SizedBox(height: height * 0.028),
                      elevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        title: "No",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
