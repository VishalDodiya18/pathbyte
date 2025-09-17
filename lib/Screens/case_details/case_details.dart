// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/extensions.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Screens/case_details/add_payment_dailoge.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/utils/app_color.dart';

class CaseDetailsPage extends StatelessWidget {
  CaseDetailsPage({super.key});
  final CaseDetailsContoller controller = Get.find<CaseDetailsContoller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
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
                                  controller.caseDetails?.labcenter?.name ?? "",
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
                                  controller.caseDetails?.labcenter?.location ??
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.bordercolor),
                  ),
                  child: Column(
                    spacing: 20.0.w,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 15.0,
                        ),
                        child: IntrinsicHeight(
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
                                      title:
                                          "${controller.caseDetails?.patient?.phoneNumbers?.first ?? "N/A"}",
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
                      ),
                      Divider(height: 1),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth:
                                MediaQuery.of(context).size.width *
                                0.9, // minimum full screen width
                          ),
                          child: DataTable(
                            headingRowHeight: 30,
                            dataRowMinHeight: 36,
                            dividerThickness: 0,
                            columnSpacing: 20,

                            columns: [
                              DataColumn(
                                label: Text(
                                  "Group Name",
                                  style: TextStyle(
                                    fontSize: 13.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Code",
                                  style: TextStyle(
                                    fontSize: 13.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Test name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.h,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "R.D.",
                                  style: TextStyle(
                                    fontSize: 13.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              DataColumn(
                                label: Text(
                                  "Price",
                                  style: TextStyle(
                                    fontSize: 13.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                numeric: true,
                              ),
                            ],
                            rows: [
                              ...List.generate(controller.selectedTests.length, (
                                index,
                              ) {
                                final test = controller.selectedTests[index];
                                return DataRow(
                                  cells: [
                                    // DataCell(Text("${index + 1}")),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          " - ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13.h,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        test.testId ?? "",
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        test.name ?? "",
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        (test.reportingDays ?? 1).toString(),
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "₹${test.price}/-",
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    // DataCell(
                                    //   IconButton(
                                    //     icon: const Icon(Icons.delete, color: Colors.red),
                                    //     onPressed: () {
                                    //       controller.toggleSelection(test);
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                );
                              }),

                              for (
                                int i = 0;
                                i <
                                    (controller.selectedGroupTests ?? [])
                                        .length;
                                i++
                              )
                                DataRow(
                                  cells: [
                                    // DataCell(Text("${index + 1}")),
                                    DataCell(
                                      Text(
                                        controller.selectedGroupTests[i].name ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        controller
                                                .selectedGroupTests[i]
                                                .groupId ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        child: Text(
                                          (controller
                                                      .selectedGroupTests[i]
                                                      .tests ??
                                                  [])
                                              .map((e) => e.name ?? "")
                                              .join(" , "),
                                          style: TextStyle(
                                            fontSize: 13.h,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        (controller
                                                        .selectedGroupTests[i]
                                                        .tests ??
                                                    [])
                                                .isEmpty
                                            ? "1"
                                            : (controller
                                                          .selectedGroupTests[i]
                                                          .tests ??
                                                      [])
                                                  .map(
                                                    (e) => e.reportingDays ?? 0,
                                                  )
                                                  .reduce(
                                                    (a, b) => a > b ? a : b,
                                                  )
                                                  .toString(),
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "${formatIndianCurrency(controller.selectedGroupTests[i].price ?? 0)}/-",
                                        style: TextStyle(
                                          fontSize: 13.h,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                    // DataCell(
                                    //   IconButton(
                                    //     icon: const Icon(Icons.delete, color: Colors.red),
                                    //     onPressed: () {
                                    //       controller.toggleSelection(test);
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                            ],

                            // rows: (controller.caseDetails?.casetests ?? [])
                            //     .map((testItem) {
                            //       return DataRow(
                            //         cells: [
                            //           DataCell(
                            //             Text(
                            //               testItem.test?.testId ?? "",
                            //               style: TextStyle(
                            //                 fontSize: 13.h,

                            //                 fontWeight: FontWeight.w500,
                            //                 color: Colors.black45,
                            //               ),
                            //             ),
                            //           ),
                            //           DataCell(
                            //             Text(
                            //               testItem.test?.testId ?? "",
                            //               style: TextStyle(
                            //                 fontSize: 13.h,

                            //                 fontWeight: FontWeight.w500,
                            //                 color: Colors.black45,
                            //               ),
                            //             ),
                            //           ),
                            //           DataCell(
                            //             Text(
                            //               testItem.test?.name ?? "",
                            //               style: TextStyle(
                            //                 fontSize: 13.h,

                            //                 fontWeight: FontWeight.w500,
                            //                 color: Colors.black45,
                            //               ),
                            //             ),
                            //           ),
                            //           DataCell(
                            //             Text(
                            //               formatIndianCurrency(
                            //                 testItem.test?.price ?? 0,
                            //               ),
                            //               style: TextStyle(
                            //                 fontSize: 13.h,

                            //                 fontWeight: FontWeight.w500,
                            //                 color: Colors.black45,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       );
                            //     })
                            //     .toList(),
                          ),
                        ),
                      ),

                      Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,
                        ),
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
                                            controller.gettotalamount(),
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
                                              "${formatIndianCurrency(controller.caseDetails?.discountValue)}",
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
                                            controller
                                                .gettotalwitdiscountamount(),
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
                                                .gettotalwitdiscountwithrecivedamount(),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextConstant(
                      title: "Payment History",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    if ((controller.caseDetails?.finalAmount !=
                        (controller.caseDetails?.totalTransactionAmount)))
                      Flexible(
                        child: elevatedButton(
                          width: 100.0,
                          fontSize: 14,
                          height: 30.0,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddPaymentDialog(
                                caseid: controller.caseDetails?.id,
                                maxvalue: controller
                                    .gettotalwitdiscountwithrecivedamount(),
                              ),
                            ).then((result) {
                              if (result != null) {
                                print(
                                  "Amount: ${result['amount']}, Method: ${result['method']}",
                                );
                              }
                            });
                          },
                          title: "Add Payment",
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15.0.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowHeight: 40,
                    dataRowMinHeight: 4,

                    dataRowMaxHeight: 36,
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
                      DataColumn(
                        label: Text(
                          "Date - Time",
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

                          // DataCell(Text(tx["receiver"]!)),
                          DataCell(
                            Row(
                              children: [
                                Text(formatIndianCurrency(tx.amountGiven ?? 0)),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  side: BorderSide(color: Colors.blue.shade400),
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
                          ),
                          DataCell(
                            Text(
                              DateFormat("dd, MMM yyyy hh:mm a").format(
                                tx.createdAt ??
                                    DateTime.parse("2000-01-01T10:28:22.492Z"),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20.0.h),
              ],
            ),
    );
  }
}
