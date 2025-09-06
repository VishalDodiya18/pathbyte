import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Screens/report_details/controller_report_details_screen.dart';
import 'package:labapp/Screens/report_details/report_table.dart';
import 'package:labapp/utils/app_color.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportDetailsContoller controller =
        Get.find<ReportDetailsContoller>();

    return Scaffold(
      appBar: AppBar(title: const Text('Report Details')),
      bottomNavigationBar: Padding(
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
            SizedBox(height: 10.0),
            elevatedButton(
              title: "Cancel",
              onPressed: () {},
              backgroundColor: AppColor.greycolor,
            ),
          ],
        ),
      ),
      body: ListView(
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
                buildReportRow(title: "Case ID :", value: "#0025"),
                buildReportRow(
                  title: "Patient Name :",
                  value: "Sanjay Thakur  (#12345)",
                ),
                buildReportRow(title: "Age/ Sex :", value: "32/ M"),
                buildReportRow(title: "Referred By :", value: "Dr. Parul Singhal"),
                buildReportRow(title: "Registration Time :", value: "#PT0025"),
                buildReportRow(title: "Collection Time :", value: "Sanjay Thakur"),
                buildReportRow(title: "Reported Time :", value: "Dr. Parul Singhal"),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          elevatedButton(title: "Preview Report", onPressed: () {}),
          SizedBox(height: 15.0),
          ListView.separated(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemBuilder: (context, index) => ReportTable(),
          ),
        ],
      ),
    );
  }
}
