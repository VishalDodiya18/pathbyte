import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Screens/bookcase_screen/bookcase_widget.dart';
import 'package:labapp/Screens/case_details/controller_case_details_screen.dart';
import 'package:labapp/utils/app_color.dart';

class CaseDetailsScreen extends StatelessWidget {
  const CaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CaseDetailsContoller controller = Get.find<CaseDetailsContoller>();

    return Scaffold(
      appBar: AppBar(title: const Text('Case Details')),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              TextConstant(
                title: "Date :-  ",
                fontSize: 15.0,
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
              TextConstant(
                title: "20, Aug 2025",
                fontSize: 15.0,

                color: AppColor.greycolor,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            spacing: 15.w,
            children: [
              // TextConstant(
              //   title: "G",
              //   fontWeight: FontWeight.bold,
              //   color: AppColor.primary,
              //   fontSize: 40.0,
              // ),
              Expanded(
                child: Column(
                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TextConstant(
                      title: "Goel Diagnostic Center",
                      fontSize: 15.0,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    TextConstant(
                      title: "+91 3234434324",
                      fontSize: 13.0,

                      color: AppColor.greycolor,
                    ),
                    TextConstant(
                      title: "Cheema Chauraha,Kashipur",

                      color: AppColor.greycolor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    TextConstant(
                      title: "Business address",
                      fontSize: 15.0,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    TextConstant(
                      title: "City, State, IN - 000 000",
                      fontSize: 13.0,
                      color: AppColor.greycolor,
                    ),
                    TextConstant(
                      title: "TAX ID 00XXXXX1234X0XX",
                      fontSize: 13.0,
                      color: AppColor.greycolor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 25.0.h),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.bordercolor),
            ),
            child: Column(
              spacing: 20.0.w,
              children: [
                const IntrinsicHeight(
                  child: Row(
                    spacing: 10.0,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 4.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextConstant(
                              title: "Patient Details",
                              fontSize: 14.0,
                              color: AppColor.greycolor,
                            ),
                            TextConstant(
                              title: "Saurabh Bhatnagar",
                              fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            TextConstant(
                              title: "24/ M",
                              fontSize: 14.0,
                              color: AppColor.greycolor,
                            ),
                            TextConstant(
                              title: "Kashipur",
                              fontSize: 13.0,
                              color: AppColor.greycolor,
                            ),
                            TextConstant(
                              title: "+91 435345 43534",
                              fontSize: 13.0,
                              color: AppColor.greycolor,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          spacing: 4.0,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextConstant(
                              title: "Case ID",
                              fontSize: 14.0,
                              color: AppColor.greycolor,
                            ),
                            TextConstant(
                              title: "#CS-013455",
                              fontWeight: FontWeight.bold,
                            ),
                            Spacer(),
                            TextConstant(
                              title: "Referred By",
                              fontSize: 14.0,
                              color: AppColor.greycolor,
                            ),
                            TextConstant(
                              title: "Dr. Parul Singhal",
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextConstant(
                        title: "TEST NAME",
                        height: 0.1,
                        color: AppColor.greycolor,
                        fontWeight: FontWeight.w500,
                      ),
                      TextConstant(
                        title: "RATE",
                        height: 0.1,
                        color: AppColor.greycolor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                for (int i = 0; i < 5; i++)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 5,
                      children: [
                        Expanded(
                          child: TextConstant(
                            title: "HB",
                            height: 0.1,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: TextConstant(
                            title: "3,000.00",
                            height: 0.1,
                            textAlign: TextAlign.end,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Divider(height: 1),
                const Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10.0,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 3.0),
                          child: TextConstant(
                            title: "This is a computer generated receipt.",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 5,
                              children: [
                                Expanded(
                                  child: TextConstant(
                                    title: "Total",
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: TextConstant(
                                    title: "4,500.00",
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 5,
                              children: [
                                Expanded(
                                  child: TextConstant(
                                    title: "Paid",

                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: TextConstant(
                                    title: "4,000.00",

                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            Divider(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 5,
                              children: [
                                Expanded(
                                  child: TextConstant(
                                    title: "Balance",
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: TextConstant(
                                    title: "500.00",
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25.0.h),

          Row(
            spacing: 10.0.w,
            children: [
              Expanded(
                child: elevatedButton(
                  title: "Send on Whatsapp",
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: elevatedButton(title: "Print Receipt", onPressed: () {}),
              ),
            ],
          ),
          SizedBox(height: 25.0.h),
          TextConstant(
            title: "Payment History",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          SizedBox(height: 15.0.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),
              columns: const [
                DataColumn(
                  label: Text(
                    "ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Date - Time",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Received By",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Amount",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Mode",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: controller.transactions.map((tx) {
                return DataRow(
                  cells: [
                    DataCell(Text(tx["id"]!)),
                    DataCell(Text(tx["date"]!)),
                    DataCell(Text(tx["receiver"]!)),
                    DataCell(
                      Row(
                        children: [
                          Text(tx["amount"]!),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          side: BorderSide(color: Colors.blue.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          tx["mode"]!,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
