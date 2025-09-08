import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
    return controller.reporting.isFalse && controller.reportDetailsModel == null
        ? Center(
            child: Text(
              "Report Detail Not Found",
              style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
            ),
          )
        : ListView(
            shrinkWrap: T,
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(15.0),
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
                  spacing: 22.0,
                  children: [
                    buildReportRow(
                      title: "Case ID :",
                      value:
                          "#${controller.reportDetailsModel?.data?.reportdetail?.caseDetails?.caseId ?? ""}",
                    ),
                    buildReportRow(
                      title: "Patient Name :",
                      value: "Sanjay Thakur  (#12345)",
                    ),
                    buildReportRow(title: "Age/ Sex :", value: "32/ M"),
                    buildReportRow(
                      title: "Referred By :",
                      value: "Dr. Parul Singhal",
                    ),
                    buildReportRow(
                      title: "Registration Time :",
                      value: "#PT0025",
                    ),
                    buildReportRow(
                      title: "Collection Time :",
                      value: "Sanjay Thakur",
                    ),
                    buildReportRow(
                      title: "Reported Time :",
                      value: "Dr. Parul Singhal",
                    ),
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
            ],
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
          height: 0.1,
          textAlign: TextAlign.start,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(
        child: TextConstant(
          title: value,
          height: 0.1,
          textAlign: TextAlign.end,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
