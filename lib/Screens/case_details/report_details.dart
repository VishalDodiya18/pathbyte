import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:labapp/Screens/report_details/report_details_screen.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: T,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColor.bordercolor),
          ),
          child: Column(
            spacing: 22.0,
            children: [
              buildReportRow(title: "Case ID :", value: "#0025"),
              buildReportRow(
                title: "Patient Name :",
                value: "Sanjay Thakur  (#12345)",
              ),
              buildReportRow(title: "Age/ Sex :", value: "32/ M"),
              buildReportRow(
                title: "Referred By :",
                value: "Dr. Parul Singhal",
              ),
              buildReportRow(title: "Registration Time :", value: "#PT0025"),
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
