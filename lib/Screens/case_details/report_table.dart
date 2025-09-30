import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pathbyte/Constants/custom_dropDown.dart';
import 'package:pathbyte/Constants/textfield_constant.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/models/report_details_model.dart';
import 'package:pathbyte/utils/app_color.dart';

class ReportTable extends StatelessWidget {
  bool isfinal;
  Category category;
  ReportTable({required this.category, required this.isfinal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          category.name ?? "",
          style: TextStyle(
            color: const Color(0xff0A1B39),

            fontSize: 16.h,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 2,
          width: 120,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: AppColor.primary,
        ),
        // Text(
        //   "Complete Blood Count (CBC)",
        //   style: TextStyle(
        //     fontWeight: FontWeight.w500,
        //     fontSize: 15.h,
        //     color: Color(0xff0A1B39),
        //   ),
        // ),
        // const SizedBox(height: 10),

        /// DataTable
        for (int i = 0; i < (category.groupedTests ?? []).length; i++) ...[
          const SizedBox(height: 15.0),
          Text(
            category.groupedTests?[i].name ?? "",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15.0),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 40,
              dataRowMinHeight: 4,

              dataRowMaxHeight: 50,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columnSpacing: 20,
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),
              columns: const [
                DataColumn(
                  label: Text(
                    "S.No",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // DataColumn(
                //   label: Text(
                //     "Group Name",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                DataColumn(
                  label: Text(
                    "Test Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Value",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Unit",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Reference",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],

              rows: [
                for (
                  int j = 0;
                  j < (category.groupedTests?[i].caseTests ?? []).length;
                  j++
                ) ...[
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          j == 0 ? "${i + 1}" : "",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // DataCell(
                      //   (category
                      //                   .groupedTests?[i]
                      //                   .caseTests?[j]
                      //                   .test
                      //                   ?.characteristics ??
                      //               [])
                      //           .isNotEmpty
                      //       ? const SizedBox()
                      //       : Center(
                      //           child: Text(
                      //             j == 0
                      //                 ? (category.groupedTests?[i].name ?? "")
                      //                 : " - ",
                      //             textAlign: TextAlign.center,
                      //           ),
                      //         ),
                      // ),
                      DataCell(
                        Text(
                          category.groupedTests?[i].caseTests?[j].test?.name ??
                              "",
                        ),
                      ),
                      DataCell(
                        (category
                                        .groupedTests?[i]
                                        .caseTests?[j]
                                        .characteristics ??
                                    [])
                                .isNotEmpty
                            ? const SizedBox()
                            : (category
                                              .groupedTests?[i]
                                              .caseTests?[j]
                                              .test
                                              ?.testType ??
                                          "")
                                      .toLowerCase() ==
                                  "numeric"
                            ? GetBuilder<CaseDetailsContoller>(
                                builder: (controller) {
                                  return Row(
                                    children: [
                                      if (areValuesValid(
                                        category
                                            .groupedTests![i]
                                            .caseTests![j]
                                            .lowvalue
                                            .text,
                                        category
                                            .groupedTests![i]
                                            .caseTests![j]
                                            .appliedReferenceRange
                                            ?.lowValue
                                            .toString(),
                                        category
                                            .groupedTests![i]
                                            .caseTests![j]
                                            .appliedReferenceRange
                                            ?.highValue
                                            .toString(),
                                      ))
                                        SizedBox(
                                          width: 20.0,
                                          child: Text(
                                            checkRange(
                                              category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .lowvalue
                                                  .text,
                                              category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .appliedReferenceRange
                                                  ?.lowValue
                                                  .toString(),
                                              category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .appliedReferenceRange
                                                  ?.highValue
                                                  .toString(),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: getRangeColor(
                                                category
                                                    .groupedTests![i]
                                                    .caseTests![j]
                                                    .lowvalue
                                                    .text,
                                                category
                                                    .groupedTests![i]
                                                    .caseTests![j]
                                                    .appliedReferenceRange
                                                    ?.lowValue
                                                    .toString(),
                                                category
                                                    .groupedTests![i]
                                                    .caseTests![j]
                                                    .appliedReferenceRange
                                                    ?.highValue
                                                    .toString(),
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minWidth: 80.w,
                                          ),
                                          child: TextFieldConstant(
                                            isReadOnly: isfinal,
                                            onChanged: (v) {
                                              controller.update();
                                            },
                                            inputFormatters: [
                                              DecimalTextInputFormatter(),
                                            ],
                                            contentPadding:
                                                const EdgeInsets.all(10.0),
                                            fillColor: const Color(0xffEEEEEE),
                                            controller: category
                                                .groupedTests![i]
                                                .caseTests![j]
                                                .lowvalue,
                                            hintText: "Select ...",
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(width: 6),
                                      // Flexible(
                                      //   child: Container(
                                      //     constraints: BoxConstraints(
                                      //       minWidth: 80.w,
                                      //     ),
                                      //     child: TextFieldConstant(
                                      //onChanged: (v){
                                      //},
                                      //inputFormatters: [DecimalTextInputFormatter()],
                                      //       contentPadding: const EdgeInsets.all(
                                      //         10.0,
                                      //       ),
                                      //       fillColor: const Color(0xffEEEEEE),
                                      //       controller: category
                                      //           .groupedTests![i]
                                      //           .caseTests![j]
                                      //           .highvalue,
                                      //        hintText: "Select ...",
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              )
                            : GetBuilder<CaseDetailsContoller>(
                                builder: (controller) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 0.0,
                                    ),
                                    child: CustomDropdown<dynamic>(
                                      ischange: !isfinal,
                                      backgroundColor: const Color(0xffEEEEEE),
                                      items:
                                          (category
                                              .groupedTests![i]
                                              .caseTests![j]
                                              .test
                                              ?.possibleStringValues ??
                                          []),
                                      constraints: const BoxConstraints(
                                        minHeight: 40.0,
                                      ),
                                      selectedValue:
                                          category
                                              .groupedTests![i]
                                              .caseTests![j]
                                              .lowvalue
                                              .text
                                              .isEmpty
                                          ? null
                                          : category
                                                .groupedTests![i]
                                                .caseTests![j]
                                                .lowvalue
                                                .text,
                                      itemLabel: (item) => item,
                                      hintText: "Select ...",
                                      prefixIcon: Icons.folder,
                                      onChanged: (value) {
                                        category
                                                .groupedTests![i]
                                                .caseTests![j]
                                                .lowvalue
                                                .text =
                                            value;
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                      DataCell(
                        (category
                                        .groupedTests?[i]
                                        .caseTests?[j]
                                        .characteristics ??
                                    [])
                                .isNotEmpty
                            ? const SizedBox()
                            : Text(
                                category.groupedTests![i].caseTests![j].unit ??
                                    "",
                              ),
                      ),
                      DataCell(
                        (category
                                        .groupedTests?[i]
                                        .caseTests?[j]
                                        .characteristics ??
                                    [])
                                .isNotEmpty
                            ? const SizedBox()
                            : Center(
                                child: Text(
                                  (category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .test
                                                  ?.testType ??
                                              "") ==
                                          "NonNumeric"
                                      ? (category
                                                .groupedTests?[i]
                                                .caseTests?[j]
                                                .appliedReferenceRange
                                                ?.stringValue ??
                                            "")
                                      : "${category.groupedTests![i].caseTests![j].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.groupedTests![i].caseTests![j].appliedReferenceRange?.highValue.toString() ?? ""} ",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    ],
                  ),

                  for (
                    int k = 0;
                    k <
                        (category
                                    .groupedTests?[i]
                                    .caseTests?[j]
                                    .characteristics ??
                                [])
                            .length;
                    k++
                  )
                    DataRow(
                      cells: [
                        const DataCell(SizedBox()),
                        // const DataCell(SizedBox()),
                        DataCell(
                          Text(
                            category
                                    .groupedTests?[i]
                                    .caseTests?[j]
                                    .characteristics?[k]
                                    .name ??
                                "",
                          ),
                        ),
                        DataCell(
                          (category
                                              .groupedTests?[i]
                                              .caseTests?[j]
                                              .characteristics?[k]
                                              .charType ??
                                          "")
                                      .toLowerCase() ==
                                  "numeric"
                              ? GetBuilder<CaseDetailsContoller>(
                                  builder: (controller) {
                                    return Row(
                                      children: [
                                        if (areValuesValid(
                                          category
                                              .groupedTests![i]
                                              .caseTests![j]
                                              .characteristics![k]
                                              .lowvalue
                                              .text,
                                          category
                                              .groupedTests?[i]
                                              .caseTests?[j]
                                              .characteristics?[k]
                                              .appliedReferenceRange
                                              ?.lowValue
                                              .toString(),
                                          category
                                              .groupedTests?[i]
                                              .caseTests?[j]
                                              .characteristics?[k]
                                              .appliedReferenceRange
                                              ?.highValue
                                              .toString(),
                                        ))
                                          SizedBox(
                                            width: 20.0,
                                            child: Text(
                                              checkRange(
                                                category
                                                    .groupedTests![i]
                                                    .caseTests![j]
                                                    .characteristics![k]
                                                    .lowvalue
                                                    .text,
                                                category
                                                    .groupedTests?[i]
                                                    .caseTests?[j]
                                                    .characteristics?[k]
                                                    .appliedReferenceRange
                                                    ?.lowValue
                                                    .toString(),
                                                category
                                                    .groupedTests?[i]
                                                    .caseTests?[j]
                                                    .characteristics?[k]
                                                    .appliedReferenceRange
                                                    ?.highValue
                                                    .toString(),
                                              ),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: getRangeColor(
                                                  category
                                                      .groupedTests![i]
                                                      .caseTests![j]
                                                      .characteristics![k]
                                                      .lowvalue
                                                      .text,
                                                  category
                                                      .groupedTests?[i]
                                                      .caseTests?[j]
                                                      .characteristics?[k]
                                                      .appliedReferenceRange
                                                      ?.lowValue
                                                      .toString(),
                                                  category
                                                      .groupedTests?[i]
                                                      .caseTests?[j]
                                                      .characteristics?[k]
                                                      .appliedReferenceRange
                                                      ?.highValue
                                                      .toString(),
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 80.w,
                                            ),
                                            child: TextFieldConstant(
                                              isReadOnly:
                                                  isfinal ||
                                                  isValidMathExpression(
                                                    category
                                                        .groupedTests![i]
                                                        .caseTests![j]
                                                        .characteristics![k]
                                                        .formula,
                                                  ),

                                              onChanged: (v) {
                                                EasyDebounce.debounce(
                                                  'validonchanges-debounce',
                                                  const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  () {
                                                    validateTestOnChange(
                                                      category
                                                          .groupedTests![i]
                                                          .caseTests![j],
                                                    );
                                                  },
                                                );

                                                // evaluateCharacteristic(
                                                //   category
                                                //       .groupedTests![i]
                                                //       .caseTests![j]
                                                //       .characteristics![k],
                                                //   category
                                                //           .groupedTests![i]
                                                //           .caseTests![j]
                                                //           .characteristics ??
                                                //       [],
                                                // );
                                                controller.update();
                                              },
                                              inputFormatters: [
                                                DecimalTextInputFormatter(),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.all(10.0),
                                              fillColor: const Color(
                                                0xffEEEEEE,
                                              ),
                                              controller:
                                                  isValidMathExpression(
                                                    category
                                                        .groupedTests![i]
                                                        .caseTests![j]
                                                        .characteristics![k]
                                                        .formula,
                                                  )
                                                  ? TextEditingController(
                                                      text: evaluateCharacteristicValue(
                                                        category
                                                            .groupedTests![i]
                                                            .caseTests![j]
                                                            .characteristics![k],
                                                        category
                                                            .groupedTests![i]
                                                            .caseTests![j]
                                                            .characteristics!,
                                                      ).toString(),
                                                    )
                                                  : category
                                                        .groupedTests![i]
                                                        .caseTests![j]
                                                        .characteristics![k]
                                                        .lowvalue,
                                              hintText: "Select ...",
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(width: 6),
                                        // Flexible(
                                        //   child: Container(
                                        //     constraints: BoxConstraints(
                                        //       minWidth: 80.w,
                                        //     ),
                                        //     child: TextFieldConstant(
                                        //onChanged: (v){
                                        //},
                                        //inputFormatters: [DecimalTextInputFormatter()],
                                        //       contentPadding: const EdgeInsets.all(
                                        //         10.0,
                                        //       ),
                                        //       fillColor: const Color(0xffEEEEEE),
                                        //       controller: category
                                        //           .groupedTests![i]
                                        //           .caseTests![j]
                                        //           .test!
                                        //           .characteristics![k]
                                        //           .highvalue,
                                        //        hintText: "Select ...",
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    );
                                  },
                                )
                              : GetBuilder<CaseDetailsContoller>(
                                  builder: (controller) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                        horizontal: 0.0,
                                      ),
                                      child: CustomDropdown<dynamic>(
                                        ischange: !isfinal,
                                        backgroundColor: const Color(
                                          0xffEEEEEE,
                                        ),
                                        items:
                                            (category
                                                .groupedTests![i]
                                                .caseTests![j]
                                                .test
                                                ?.characteristics![k]
                                                .possibleStringValues ??
                                            []),
                                        constraints: const BoxConstraints(
                                          minHeight: 40.0,
                                        ),
                                        selectedValue:
                                            category
                                                .groupedTests![i]
                                                .caseTests![j]
                                                .characteristics![k]
                                                .lowvalue
                                                .text
                                                .isEmpty
                                            ? null
                                            : category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .characteristics![k]
                                                  .lowvalue
                                                  .text,
                                        itemLabel: (item) => item,
                                        hintText: "Select ...",
                                        prefixIcon: Icons.folder,
                                        onChanged: (value) {
                                          category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .characteristics![k]
                                                  .lowvalue
                                                  .text =
                                              value;
                                          controller.update();
                                        },
                                      ),
                                    );
                                  },
                                ),
                        ),
                        DataCell(
                          Text(
                            category
                                    .groupedTests?[i]
                                    .caseTests?[j]
                                    .characteristics?[k]
                                    .unit ??
                                "",
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              "${category.groupedTests?[i].caseTests?[j].characteristics?[k].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.groupedTests?[i].caseTests?[j].characteristics?[k].appliedReferenceRange?.highValue.toString() ?? ""} ",

                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ],
        if ((category.ungroupedTests ?? []).isNotEmpty) ...[
          const SizedBox(height: 20.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 40,
              dataRowMinHeight: 4,

              dataRowMaxHeight: 50,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columnSpacing: 20,
              border: TableBorder.all(color: Colors.grey.shade300, width: 1),
              columns: const [
                DataColumn(
                  label: Text(
                    "S.No",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // DataColumn(
                //   label: Text(
                //     "Group Name",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                DataColumn(
                  label: Text(
                    "Test name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Value",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Unit",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Reference",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],

              rows: [
                for (
                  int i = 0;
                  i < (category.ungroupedTests ?? []).length;
                  i++
                ) ...[
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          // category.ungroupedTests![i].charMap.toString(),
                          "${(category.groupedTests ?? []).length + i + 1}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // const DataCell(
                      //   Center(child: Text(" - ", textAlign: TextAlign.center)),
                      // ),
                      DataCell(
                        Text(
                          category.ungroupedTests?[i].test?.name ?? "",
                          style: TextStyle(
                            fontWeight:
                                (category.ungroupedTests?[i].characteristics ??
                                        [])
                                    .isNotEmpty
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                      DataCell(
                        (category.ungroupedTests?[i].characteristics ?? [])
                                .isNotEmpty
                            ? const SizedBox()
                            : (category.ungroupedTests?[i].test?.testType ?? "")
                                      .toLowerCase() ==
                                  "numeric"
                            ? GetBuilder<CaseDetailsContoller>(
                                builder: (controller) {
                                  return Row(
                                    children: [
                                      if (areValuesValid(
                                        category
                                            .ungroupedTests![i]
                                            .lowvalue
                                            .text,
                                        category
                                            .ungroupedTests?[i]
                                            .appliedReferenceRange
                                            ?.lowValue
                                            .toString(),
                                        category
                                            .ungroupedTests?[i]
                                            .appliedReferenceRange
                                            ?.highValue
                                            .toString(),
                                      ))
                                        SizedBox(
                                          width: 20.0,
                                          child: Text(
                                            checkRange(
                                              category
                                                  .ungroupedTests![i]
                                                  .lowvalue
                                                  .text,
                                              category
                                                  .ungroupedTests?[i]
                                                  .appliedReferenceRange
                                                  ?.lowValue
                                                  .toString(),
                                              category
                                                  .ungroupedTests?[i]
                                                  .appliedReferenceRange
                                                  ?.highValue
                                                  .toString(),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: getRangeColor(
                                                category
                                                    .ungroupedTests![i]
                                                    .lowvalue
                                                    .text,
                                                category
                                                    .ungroupedTests?[i]
                                                    .appliedReferenceRange
                                                    ?.lowValue
                                                    .toString(),
                                                category
                                                    .ungroupedTests?[i]
                                                    .appliedReferenceRange
                                                    ?.highValue
                                                    .toString(),
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minWidth: 80.w,
                                          ),
                                          child: TextFieldConstant(
                                            isReadOnly: isfinal,

                                            onChanged: (v) {
                                              controller.update();
                                            },
                                            inputFormatters: [
                                              DecimalTextInputFormatter(),
                                            ],
                                            contentPadding:
                                                const EdgeInsets.all(10.0),
                                            fillColor: const Color(0xffEEEEEE),
                                            controller: category
                                                .ungroupedTests![i]
                                                .lowvalue,
                                            hintText: "Select ...",
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(width: 6),
                                      // Flexible(
                                      //   child: Container(
                                      //     constraints: BoxConstraints(minWidth: 80.w),
                                      //     child: TextFieldConstant(
                                      //onChanged: (v){
                                      //},
                                      //inputFormatters: [DecimalTextInputFormatter()],
                                      //       contentPadding: const EdgeInsets.all(
                                      //         10.0,
                                      //       ),
                                      //       fillColor: const Color(0xffEEEEEE),
                                      //       controller:
                                      //           category.ungroupedTests![i].highvalue,
                                      //        hintText: "Select ...",
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              )
                            : GetBuilder<CaseDetailsContoller>(
                                builder: (controller) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 0.0,
                                    ),
                                    child: CustomDropdown<dynamic>(
                                      ischange: !isfinal,
                                      backgroundColor: const Color(0xffEEEEEE),
                                      items:
                                          (category
                                              .ungroupedTests?[i]
                                              .test
                                              ?.possibleStringValues ??
                                          []),
                                      constraints: const BoxConstraints(
                                        minHeight: 40.0,
                                      ),
                                      selectedValue:
                                          category
                                              .ungroupedTests![i]
                                              .lowvalue
                                              .text
                                              .isEmpty
                                          ? null
                                          : category
                                                .ungroupedTests![i]
                                                .lowvalue
                                                .text,
                                      itemLabel: (item) => item,
                                      hintText: "Select ...",
                                      prefixIcon: Icons.folder,
                                      onChanged: (value) {
                                        category
                                                .ungroupedTests![i]
                                                .lowvalue
                                                .text =
                                            value;
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                      DataCell(
                        (category.ungroupedTests?[i].characteristics ?? [])
                                .isNotEmpty
                            ? const SizedBox()
                            : Text(category.ungroupedTests?[i].unit ?? ""),
                      ),
                      DataCell(
                        (category.ungroupedTests?[i].characteristics ?? [])
                                .isNotEmpty
                            ? const SizedBox()
                            : Center(
                                child: Text(
                                  (category.ungroupedTests?[i].test?.testType ??
                                              "") ==
                                          "NonNumeric"
                                      ? (category
                                                .ungroupedTests?[i]
                                                .appliedReferenceRange
                                                ?.stringValue ??
                                            "")
                                      : "${category.ungroupedTests?[i].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.ungroupedTests?[i].appliedReferenceRange?.highValue.toString() ?? ""} ",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    ],
                  ),
                  for (
                    int j = 0;
                    j <
                        (category.ungroupedTests?[i].characteristics ?? [])
                            .length;
                    j++
                  )
                    DataRow(
                      cells: [
                        const DataCell(SizedBox()),
                        // const DataCell(SizedBox()),
                        DataCell(
                          Text(
                            category
                                    .ungroupedTests?[i]
                                    .characteristics?[j]
                                    .name ??
                                "",
                          ),
                        ),
                        DataCell(
                          (category
                                              .ungroupedTests?[i]
                                              .characteristics?[j]
                                              .charType ??
                                          "")
                                      .toLowerCase() ==
                                  "numeric"
                              ? GetBuilder<CaseDetailsContoller>(
                                  builder: (controller) {
                                    return Row(
                                      children: [
                                        if (areValuesValid(
                                          category
                                              .ungroupedTests![i]
                                              .characteristics![j]
                                              .lowvalue
                                              .text,
                                          category
                                              .ungroupedTests?[i]
                                              .characteristics?[j]
                                              .appliedReferenceRange
                                              ?.lowValue
                                              .toString(),
                                          category
                                              .ungroupedTests?[i]
                                              .characteristics?[j]
                                              .appliedReferenceRange
                                              ?.highValue
                                              .toString(),
                                        ))
                                          Container(
                                            width: 20.0,
                                            child: Text(
                                              checkRange(
                                                category
                                                    .ungroupedTests![i]
                                                    .characteristics![j]
                                                    .lowvalue
                                                    .text,
                                                category
                                                    .ungroupedTests?[i]
                                                    .characteristics?[j]
                                                    .appliedReferenceRange
                                                    ?.lowValue
                                                    .toString(),
                                                category
                                                    .ungroupedTests?[i]
                                                    .characteristics?[j]
                                                    .appliedReferenceRange
                                                    ?.highValue
                                                    .toString(),
                                              ),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: getRangeColor(
                                                  category
                                                      .ungroupedTests![i]
                                                      .characteristics![j]
                                                      .lowvalue
                                                      .text,
                                                  category
                                                      .ungroupedTests?[i]
                                                      .characteristics?[j]
                                                      .appliedReferenceRange
                                                      ?.lowValue
                                                      .toString(),
                                                  category
                                                      .ungroupedTests?[i]
                                                      .characteristics?[j]
                                                      .appliedReferenceRange
                                                      ?.highValue
                                                      .toString(),
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: 80.w,
                                            ),
                                            child: TextFieldConstant(
                                              isReadOnly:
                                                  isfinal ||
                                                  isValidMathExpression(
                                                    category
                                                        .ungroupedTests?[i]
                                                        .characteristics?[j]
                                                        .formula,
                                                  ),

                                              onChanged: (v) {
                                                // category
                                                //         .ungroupedTests?[i]
                                                //         .characteristics =
                                                //     evaluateCharacteristicValue(
                                                //       category
                                                //           .ungroupedTests?[i]
                                                //           .characteristics?[j],
                                                //       category
                                                //               .ungroupedTests?[i]
                                                //               .characteristics ??
                                                //           [],
                                                //     );
                                                controller.update();
                                                EasyDebounce.debounce(
                                                  'validonchanges-debounce',
                                                  const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  () {
                                                    validateTestOnChange2(
                                                      category
                                                          .ungroupedTests![i],
                                                      category
                                                          .ungroupedTests![i]
                                                          .test!,
                                                    );
                                                  },
                                                );
                                              },
                                              inputFormatters: [
                                                DecimalTextInputFormatter(),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.all(10.0),
                                              fillColor: const Color(
                                                0xffEEEEEE,
                                              ),
                                              controller:
                                                  isValidMathExpression(
                                                    category
                                                        .ungroupedTests?[i]
                                                        .characteristics?[j]
                                                        .formula,
                                                  )
                                                  ? TextEditingController(
                                                      text: evaluateCharacteristicValue(
                                                        category
                                                            .ungroupedTests?[i]
                                                            .characteristics?[j],
                                                        category
                                                                .ungroupedTests?[i]
                                                                .characteristics ??
                                                            [],
                                                      ).toString(),
                                                    )
                                                  : category
                                                        .ungroupedTests![i]
                                                        .characteristics![j]
                                                        .lowvalue,
                                              hintText: "Select ...",
                                            ),
                                          ),
                                        ),

                                        // const SizedBox(width: 6),
                                        // Flexible(
                                        //   child: Container(
                                        //     constraints: BoxConstraints(
                                        //       minWidth: 80.w,
                                        //     ),
                                        //     child: TextFieldConstant(
                                        //onChanged: (v){
                                        //},
                                        //inputFormatters: [DecimalTextInputFormatter()],
                                        //       contentPadding: const EdgeInsets.all(
                                        //         10.0,
                                        //       ),
                                        //       fillColor: const Color(0xffEEEEEE),
                                        //       controller: category
                                        //           .ungroupedTests![i]
                                        //           .test!
                                        //           .characteristics![j]
                                        //           .highvalue,
                                        //        hintText: "Select ...",
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    );
                                  },
                                )
                              : GetBuilder<CaseDetailsContoller>(
                                  builder: (controller) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                        horizontal: 5.0,
                                      ),
                                      child: CustomDropdown<dynamic>(
                                        ischange: !isfinal,

                                        backgroundColor: const Color(
                                          0xffEEEEEE,
                                        ),
                                        items:
                                            (category
                                                .ungroupedTests?[i]
                                                .test
                                                ?.characteristics?[j]
                                                .possibleStringValues ??
                                            []),
                                        constraints: const BoxConstraints(
                                          minHeight: 40.0,
                                        ),
                                        selectedValue:
                                            category
                                                .ungroupedTests![i]
                                                .characteristics![j]
                                                .lowvalue
                                                .text
                                                .isEmpty
                                            ? null
                                            : category
                                                  .ungroupedTests![i]
                                                  .characteristics![j]
                                                  .lowvalue
                                                  .text,
                                        itemLabel: (item) => item,
                                        hintText: "Select ...",
                                        prefixIcon: Icons.folder,
                                        onChanged: (value) {
                                          category
                                                  .ungroupedTests![i]
                                                  .characteristics![j]
                                                  .lowvalue
                                                  .text =
                                              value;
                                          controller.update();
                                        },
                                      ),
                                    );
                                  },
                                ),
                        ),
                        DataCell(
                          Text(
                            category
                                    .ungroupedTests?[i]
                                    .characteristics?[j]
                                    .unit ??
                                "",
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              (category.ungroupedTests?[i].test?.testType ??
                                          "") ==
                                      "NonNumeric"
                                  ? (category
                                            .ungroupedTests?[i]
                                            .appliedReferenceRange
                                            ?.stringValue ??
                                        "")
                                  : "${category.ungroupedTests?[i].characteristics?[j].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.ungroupedTests?[i].characteristics?[j].appliedReferenceRange?.highValue.toString() ?? ""} ",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

num? _toNum(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  return num.tryParse(value);
}

String checkRange(String? current, String? low, String? high) {
  final c = _toNum(current);
  final l = _toNum(low);
  final h = _toNum(high);

  if (c == null || l == null || h == null) {
    return "";
  }

  if (c < l) {
    return "L";
  } else if (c > h) {
    return "H";
  }
  return "";
}

Color? getRangeColor(String? current, String? low, String? high) {
  final c = _toNum(current);
  final l = _toNum(low);
  final h = _toNum(high);

  if (c == null || l == null || h == null) {
    return null;
  }

  if (c < l) {
    return Colors.orange;
  } else if (c > h) {
    return Colors.red;
  }
  return null;
}

bool areValuesValid(String? current, String? low, String? high) {
  return _toNum(current) != null && _toNum(low) != null && _toNum(high) != null;
}

bool isValidRegex(String pattern) {
  try {
    // Agar regex compile ho gaya to valid hai
    RegExp(pattern);
    return true;
  } catch (e) {
    // Agar error aaya to invalid regex hai
    return false;
  }
}

bool isValidMathExpression(String? expression) {
  if (expression == null || expression.trim().isEmpty) {
    return false;
  }

  final exp = expression.trim();

  // Condition: कम से कम ek operator होना चाहिए
  final hasOperator = RegExp(r'[+\-*/^]').hasMatch(exp);

  if (!hasOperator) return false;

  try {
    final parser = Parser();
    parser.parse(exp);
    return true;
  } catch (e) {
    return false;
  }
}

num? evaluateCharacteristicValue(
  Characteristic? current,
  List<Characteristic> all,
) {
  if (current == null ||
      current.formula == null ||
      current.formula!.trim().isEmpty) {
    return 0;
  }

  try {
    List<String> finalstring = breakStringToChars(current.formula ?? "");

    for (var i = 0; i < finalstring.length; i++) {
      final match = all.firstWhere(
        (e) => (e.formula ?? "") == finalstring[i].toString(),
        orElse: () => Characteristic(),
      );

      finalstring[i] = match.lowvalue.text.isNotEmpty
          ? match.lowvalue.text
          : finalstring[i];
    }

    Parser parser = Parser();
    Expression exp = parser.parse(finalstring.join());

    // Evaluate expression
    final result = exp.evaluate(EvaluationType.REAL, ContextModel());

    if (result.isNaN || result.isInfinite) {
      debugPrint("⚠️ Invalid result for formula: ${current.formula}");
      return 0;
    }

    return result; // <-- actual evaluated result return hoga
  } catch (e) {
    debugPrint("⚠️ Formula evaluation failed: ${current.formula} -> $e");
    return 0;
  }
}

List<String> breakStringToChars(String input) {
  // sabhi spaces hatao aur har character ko alag karo
  return input.replaceAll(" ", "").split("");
}

// void validateTestOnChange(Test test) {
//   log((test.validationStrings == null).toString(), name: "log1");
//   log(((test.validationStrings ?? []).isEmpty).toString(), name: "log2");
//   if (test.validationStrings == null ||
//       (test.validationStrings ?? []).isEmpty) {
//     // Clear all errors if no validation
//     test.characteristics?.forEach((c) => c.error = null);
//     return;
//   }

//   log("sadsadsadsad");

//   final formulaValues = <String, double>{};
//   for (int i = 0; i < (test.characteristics?.length ?? 0); i++) {
//     final char = test.characteristics![i];
//     final value = double.tryParse(char.lowvalue.text);
//     if (value != null && char.formula != null && char.formula!.isNotEmpty) {
//       formulaValues[char.formula!.toUpperCase()] = value;
//     }
//   }

//   // Reset errors
//   test.characteristics?.forEach((c) => c.error = null);

//   List<String> allErrors = []; // Collect errors here

//   for (final validationString in test.validationStrings!) {
//     try {
//       final match = RegExp(
//         r'^([A-Z+\-*/().]+)=(\d+(?:\.\d+)?)$',
//       ).firstMatch(validationString);
//       if (match == null) continue;

//       final expression = match.group(1)!;
//       final expectedValue = double.parse(match.group(2)!);

//       final variables = RegExp(
//         r'[A-Z]',
//       ).allMatches(expression).map((e) => e.group(0)!).toSet();
//       bool allVarsPresent = variables.every(
//         (v) => formulaValues.containsKey(v),
//       );
//       if (!allVarsPresent) continue;

//       String evaluatedExp = expression;
//       formulaValues.forEach((key, value) {
//         evaluatedExp = evaluatedExp.replaceAll(key, value.toString());
//       });

//       Parser parser = Parser();
//       Expression exp = parser.parse(evaluatedExp);
//       double result = exp.evaluate(EvaluationType.REAL, ContextModel());

//       if ((result - expectedValue).abs() > 0.001) {
//         // Assign error to all involved characteristics
//         test.characteristics
//             ?.where(
//               (c) =>
//                   c.formula != null &&
//                   variables.contains(c.formula!.toUpperCase()),
//             )
//             .forEach((c) {
//               final errorMsg =
//                   "Expected $validationString = $expectedValue, got ${result.toStringAsFixed(2)}";
//               c.error = errorMsg;
//               allErrors.add(errorMsg); // Collect error for toast
//             });
//       }
//     } catch (e) {
//       print("Error validating formula $validationString: $e");
//     }
//   }
//   log(allErrors.toString());

//   // Show all errors in one toast if any
//   if (allErrors.isNotEmpty) {
//     Get.snackbar(
//       "Validation Error",
//       allErrors.join("\n"),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red.shade400,
//       colorText: Colors.white,
//       duration: Duration(seconds: 3),
//     );
//   }
// }

// void validateTestOnChange2(TestClass test) {
//   if (test.validationStrings == null || test.validationStrings!.isEmpty) {
//     test.characteristics?.forEach((c) => c.error = null);
//     return;
//   }

//   final formulaValues = <String, double>{};

//   // Collect all values from characteristics
//   for (final char in test.characteristics ?? []) {
//     final value = double.tryParse(char.lowvalue.text);
//     if (value != null && char.formula != null && char.formula!.isNotEmpty) {
//       formulaValues[char.formula!.toUpperCase()] = value;
//     }
//   }

//   test.characteristics?.forEach((c) => c.error = null); // reset

//   List<String> allErrors = [];

//   for (final validationString in test.validationStrings!) {
//     try {
//       final match = RegExp(
//         r'^([A-Z+\-*/().]+)=(\d+(?:\.\d+)?)$',
//       ).firstMatch(validationString);
//       if (match == null) continue;

//       final expression = match.group(1)!;
//       final expectedValue = double.parse(match.group(2)!);

//       // Extract variables in expression
//       final variables = RegExp(
//         r'[A-Z]',
//       ).allMatches(expression).map((e) => e.group(0)!).toSet();

//       // Skip if any variable is missing
//       if (!variables.every((v) => formulaValues.containsKey(v))) continue;

//       // Replace variables with actual values
//       String expString = expression;
//       for (final v in variables) {
//         expString = expString.replaceAll(v, formulaValues[v]!.toString());
//       }

//       // Evaluate expression
//       final parser = Parser();
//       final exp = parser.parse(expString);
//       final result = exp.evaluate(EvaluationType.REAL, ContextModel());

//       if ((result - expectedValue).abs() > 0.001) {
//         test.characteristics
//             ?.where(
//               (c) =>
//                   c.formula != null &&
//                   variables.contains(c.formula!.toUpperCase()),
//             )
//             .forEach((c) {
//               final msg =
//                   "Expected $validationString = $expectedValue, got ${result.toStringAsFixed(2)}";
//               c.error = msg;
//               allErrors.add(msg);
//             });
//       }
//     } catch (e) {
//       print("Validation error: $e");
//     }
//   }

//   if (allErrors.isNotEmpty) {
//     Get.snackbar(
//       "Validation Error",
//       allErrors.join("\n"),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red.shade400,
//       colorText: Colors.white,
//       duration: Duration(seconds: 3),
//     );
//   }
// }

/// Allowed comparators: =, !=, <, <=, >, >=
/// comparators
/// ==================== VALIDATION CORE ====================

final _compRegex = RegExp(r'(<=|>=|!=|=|<|>)');
const double _EPS = 1e-3;

/// Uppercase single-letter vars A..Z present in a string
Set<String> _varsIn(String s) => RegExp(
  r'[A-Z]',
).allMatches(s.toUpperCase()).map((m) => m.group(0)!).toSet();

bool _compare(double left, String op, double right) {
  switch (op) {
    case '=':
      return (left - right).abs() <= _EPS;
    case '!=':
      return (left - right).abs() > _EPS;
    case '<':
      return left < right - _EPS;
    case '<=':
      return left <= right + _EPS;
    case '>':
      return left > right + _EPS;
    case '>=':
      return left >= right - _EPS;
  }
  return false;
}

/// Build a vars map from your characteristics: formula -> lowvalue
Map<String, double> _buildVarsFromChars(List<Characteristic> chars) {
  final vars = <String, double>{};
  for (final c in chars) {
    log("c.formula===> ${c.lowvalue}");
    final key = (c.formula ?? '').trim().toUpperCase(); // e.g. A, B
    final txt = c.lowvalue.text.trim();
    log(txt.toString());
    final v = double.tryParse(txt);
    log(v.toString());
    if (key.isNotEmpty && v != null) {
      vars[key] = v;
    }
  }
  log(vars.toString());
  return vars;
}

/// Evaluate `expr` by binding ALL available vars from `vars` into ContextModel.
/// We don't try to pick 'needed' ones — we just bind all you provided.
double? _evalExpr(String expr, Map<String, double> vars) {
  try {
    final clean = expr.replaceAll(' ', '').toUpperCase();
    final parser = Parser();
    final parsed = parser.parse(clean);

    final cm = ContextModel();
    // Bind all user-provided variables (A, B, C...)
    for (final entry in vars.entries) {
      cm.bindVariable(Variable(entry.key), Number(entry.value));
    }

    final result = parsed.evaluate(EvaluationType.REAL, cm);
    if (result.isNaN || result.isInfinite) return null;
    return (result as num).toDouble();
  } catch (e) {
    log('Eval error for "$expr": $e');
    return null;
  }
}

/// Validate one rule like "A+B=8", "A<B", "A*B/2=25"
String? _validateOne(String rule, Map<String, double> vars) {
  final trimmed = rule.trim().toUpperCase();
  final m = _compRegex.firstMatch(trimmed);
  if (m == null) return 'Invalid rule: $rule';

  final op = m.group(0)!;
  final leftExpr = trimmed.substring(0, m.start);
  final rightExpr = trimmed.substring(m.end);

  final lVal = _evalExpr(leftExpr, vars);
  final rVal = _evalExpr(rightExpr, vars);
  if (lVal == null || rVal == null) return 'Cannot evaluate: $rule';

  final ok = _compare(lVal, op, rVal);
  log('VALIDATE "$rule" -> left=$lVal, right=$rVal, ok=$ok'); // debug
  if (!ok) {
    return 'Failed: $rule (got ${lVal.toStringAsFixed(2)} $op ${rVal.toStringAsFixed(2)} is false)';
  }
  return null;
}

/// Run all rules against current characteristics
List<String> runValidationsForCharacteristics(
  List<Characteristic> chars,
  List<String>? rules,
) {
  if (rules == null || rules.isEmpty) return const [];

  // 🚫 Jab tak saare required variables ki values nahi milti, validation skip
  if (!_hasAllRequiredValues(chars, rules)) {
    // Optionally: yaha pe koi snackbar ya silent return — requirement ke mutabik silent
    return const [];
  }

  // Ab values mil chuki hain -> vars build karke validate karo
  final vars = _buildVarsFromChars(chars);
  // Clear previous errors
  for (final c in chars) {
    c.error = null;
  }

  final errors = <String>[];
  for (final rule in rules) {
    final err = _validateOne(rule, vars);
    if (err != null) {
      errors.add(err);
      final involved = _varsIn(rule);
      for (final c in chars) {
        final key = (c.formula ?? '').trim().toUpperCase();
        if (key.isNotEmpty && involved.contains(key)) {
          c.error = err;
        }
      }
    }
  }
  return errors;
}

void validateTestOnChange(Test test) {
  final mergedRules = <String>[...(test.validationStrings ?? const [])];

  final errors = runValidationsForCharacteristics(
    test.characteristics ?? <Characteristic>[],
    mergedRules,
  );
  if (errors.isNotEmpty) {
    Get.snackbar(
      "Validation Error",
      errors.join("\n"),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

// Agar tum validateTestOnChange2 ka signature alag use kar rahe ho, same merge apply karo:
void validateTestOnChange2(Test test, TestClass testvalue) {
  final mergedRules = <String>[...(testvalue.validationStrings ?? const [])];

  final errors = runValidationsForCharacteristics(
    test.characteristics ?? <Characteristic>[],
    mergedRules,
  );
  if (errors.isNotEmpty) {
    Get.snackbar(
      "Validation Error",
      errors.join("\n"),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}

/// All variables required by the given rules (A..Z union)
Set<String> _requiredVarsFromRules(List<String> rules) {
  final out = <String>{};
  for (final r in rules) {
    out.addAll(_varsIn(r));
  }
  return out;
}

/// true => all vars used in rules have numeric values in characteristics
bool _hasAllRequiredValues(List<Characteristic> chars, List<String> rules) {
  final have = _buildVarsFromChars(chars); // from formula -> lowvalue
  final need = _requiredVarsFromRules(rules); // from rules
  if (need.isEmpty) return true; // e.g., constant-only rules
  for (final v in need) {
    if (!have.containsKey(v)) return false; // missing value for a var
  }
  return true;
}
