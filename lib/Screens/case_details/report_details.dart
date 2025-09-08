import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/case_details/controller_case_details_screen.dart';
import 'package:labapp/Screens/report_details/report_details_screen.dart';
import 'package:labapp/Screens/report_details/report_table.dart';
import 'package:labapp/utils/app_color.dart';

class ReportDetails extends StatelessWidget {
  ReportDetails({super.key});
  final CaseDetailsContoller controller = Get.find<CaseDetailsContoller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.reporting.value
          ? Center(child: CircularProgressIndicator())
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
                                title: "Patient Name :",
                                value:
                                    "${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.firstName ?? ""}  (#${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.patientId})",
                              ),
                              buildReportRow(
                                title: "Age/ Sex :",
                                value:
                                    "${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.age ?? 0}/ ${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.patient?.gender}",
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
                      Row(
                        spacing: 10.0.w,
                        children: [
                          Expanded(
                            child: elevatedButton(
                              title: "Save as Draft",
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: elevatedButton(
                              title: "Save As Final",
                              onPressed: () {},
                            ),
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
