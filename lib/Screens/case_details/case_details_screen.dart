// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/extensions.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Screens/case_details/controller_case_details_screen.dart';
import 'package:labapp/models/case_details_model.dart';
import 'package:labapp/utils/app_color.dart';

class CaseDetailsScreen extends StatelessWidget {
  CaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CaseDetailsContoller controller = Get.find<CaseDetailsContoller>();

    return Scaffold(
      appBar: AppBar(title: Text('Case Details')),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.isLoading.isFalse && controller.caseDetails == null
            ? Center(
                child: Text(
                  "Case Detail Not Found",
                  style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
                ),
              )
            : ListView(
                padding: EdgeInsets.all(15.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      TextConstant(
                        title: "Date :-  ",
                        fontSize: 15.0,
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      TextConstant(
                        title: DateFormat("dd, MMM yyyy").format(
                          controller.caseDetails?.createdAt ??
                              DateTime.parse("2000-01-01T10:28:22.492Z"),
                        ),
                        fontSize: 15.0,

                        color: AppColor.greycolor,
                      ),
                    ],
                  ),
                  if (controller.caseDetails?.labcenter != null) ...[
                    SizedBox(height: 10.0),
                    Row(
                      spacing: 10.w,
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
                            children: [
                              TextConstant(
                                title:
                                    controller.caseDetails?.labcenter?.name ??
                                    "",
                                fontSize: 15.0,
                                color: AppColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              TextConstant(
                                title:
                                    (controller
                                                .caseDetails
                                                ?.labcenter
                                                ?.contactNumbers ??
                                            [])
                                        .join(",\n"),
                                fontSize: 13.0,

                                color: AppColor.greycolor,
                              ),
                              TextConstant(
                                title:
                                    controller
                                        .caseDetails
                                        ?.labcenter
                                        ?.location ??
                                    "",

                                color: AppColor.greycolor,
                              ),
                            ],
                          ),
                        ),

                        // Expanded(
                        //   child: Column(
                        //     spacing: 2.h,
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     children: [
                        //       TextConstant(
                        //         title: "Business address",
                        //         fontSize: 15.0,
                        //         color: AppColor.primary,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       TextConstant(
                        //         title: "City, State, IN - 000 000",
                        //         fontSize: 13.0,
                        //         color: AppColor.greycolor,
                        //       ),
                        //       TextConstant(
                        //         title: "TAX ID 00XXXXX1234X0XX",
                        //         fontSize: 13.0,
                        //         color: AppColor.greycolor,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                  SizedBox(height: 25.0.h),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.bordercolor),
                    ),
                    child: Column(
                      spacing: 20.0.w,
                      children: [
                        IntrinsicHeight(
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
                                      title:
                                          "${controller.caseDetails?.patient?.firstName ?? ""} ${controller.caseDetails?.patient?.lastName ?? ""}"
                                              .capitalize ??
                                          "",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Spacer(),
                                    TextConstant(
                                      title:
                                          "${controller.caseDetails?.patient?.age ?? "0"}/ ${(controller.caseDetails?.patient?.gender ?? "").toUpperCase()}",
                                      fontSize: 14.0,
                                      color: AppColor.greycolor,
                                    ),
                                    TextConstant(
                                      title: controller.getFullAddress(
                                        controller
                                            .caseDetails
                                            ?.patient
                                            ?.address,
                                      ),
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
                                      title:
                                          "#${controller.caseDetails?.caseId}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Spacer(),
                                    TextConstant(
                                      title: "Referred By",
                                      fontSize: 14.0,
                                      color: AppColor.greycolor,
                                    ),
                                    TextConstant(
                                      title:
                                          "Dr. ${controller.caseDetails?.doctor?.firstName ?? ""} ${controller.caseDetails?.doctor?.lastName ?? ""}",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        Padding(
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
                        Divider(height: 0),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemCount:
                              (controller.caseDetails?.casetests ?? []).length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: T,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 0.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                spacing: 5,
                                children: [
                                  Expanded(
                                    child: TextConstant(
                                      title:
                                          controller
                                              .caseDetails
                                              ?.casetests?[i]
                                              .test
                                              ?.name ??
                                          "",
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
                            );
                          },
                        ),
                        SizedBox(height: 30.h),
                        Divider(height: 1),
                        Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 10.0,
                            children: [
                              // Expanded(
                              //   flex: 2,
                              //   child: Padding(
                              //     padding: EdgeInsets.only(bottom: 3.0),
                              //     child: TextConstant(
                              //       title:
                              //           "This is a computer generated receipt.",
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                // flex: 3,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Expanded(
                                          child: TextConstant(
                                            title: "Sub Total",
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextConstant(
                                            title: formatIndianCurrency(
                                              num.parse(
                                                (controller
                                                            .caseDetails
                                                            ?.totalAmount ??
                                                        0)
                                                    .toString(),
                                              ),
                                            ),
                                            textAlign: TextAlign.end,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Expanded(
                                          child: TextConstant(
                                            title: "Total Discount",
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextConstant(
                                            title:
                                                "${formatIndianCurrency(num.parse((controller.caseDetails?.discountValue ?? 0).toString()))}",
                                            textAlign: TextAlign.end,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Expanded(
                                          child: TextConstant(
                                            title: "Final Total",
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextConstant(
                                            title: formatIndianCurrency(
                                              num.parse(
                                                (controller
                                                            .caseDetails
                                                            ?.finalAmount ??
                                                        0)
                                                    .toString(),
                                              ),
                                            ),
                                            textAlign: TextAlign.end,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      spacing: 5,
                                      children: [
                                        Expanded(
                                          child: TextConstant(
                                            title: "Paid",

                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextConstant(
                                            title: formatIndianCurrency(
                                              controller
                                                      .caseDetails
                                                      ?.totalTransactionAmount ??
                                                  0,
                                            ),

                                            textAlign: TextAlign.end,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Divider(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            title: formatIndianCurrency(
                                              controller
                                                      .caseDetails
                                                      ?.remainingAmount ??
                                                  0,
                                            ),
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
                        child: elevatedButton(
                          title: "Print Receipt",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0.h),
                  if ((controller.caseDetails?.transactions ?? [])
                      .isNotEmpty) ...[
                    TextConstant(
                      title: "Payment History",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    SizedBox(height: 15.0.h),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          Colors.grey[200],
                        ),

                        border: TableBorder.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        columns: [
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
                          // DataColumn(
                          //   label: Text(
                          //     "Received By",
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   ),
                          // ),
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
                        rows: (controller.caseDetails?.transactions ?? []).map((
                          tx,
                        ) {
                          return DataRow(
                            cells: [
                              DataCell(Text(tx.transactionId ?? "")),
                              DataCell(
                                Text(
                                  DateFormat("dd, MMM yyyy hh:mm a").format(
                                    tx.createdAt ??
                                        DateTime.parse(
                                          "2000-01-01T10:28:22.492Z",
                                        ),
                                  ),
                                ),
                              ),
                              // DataCell(Text(tx["receiver"]!)),
                              DataCell(
                                Row(
                                  children: [
                                    Text(
                                      formatIndianCurrency(tx.amountGiven ?? 0),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    side: BorderSide(
                                      color: Colors.blue.shade400,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    (tx.mode ?? "").toUpperCase(),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              );
      }),
    );
  }
}
