import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:labapp/Constants/custom_dropDown.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/Screens/case_details/controller_case_details_screen.dart';
import 'package:labapp/models/report_details_model.dart';
import 'package:labapp/utils/app_color.dart';

class ReportTable extends StatelessWidget {
  Category category;
  ReportTable({required this.category});

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
                    "Code",
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
                          category
                                  .groupedTests?[i]
                                  .caseTests?[j]
                                  .test
                                  ?.testCode ??
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
                                            hintText: "",
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
                                      //       hintText: "",
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
                                      hintText: "",
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
                                  "${category.groupedTests![i].caseTests![j].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.groupedTests![i].caseTests![j].appliedReferenceRange?.highValue.toString() ?? ""} ",
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
                                              onChanged: (v) {
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
                                              controller: category
                                                  .groupedTests![i]
                                                  .caseTests![j]
                                                  .characteristics![k]
                                                  .lowvalue,
                                              hintText: "",
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
                                        //       hintText: "",
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
                                        hintText: "",
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
                    "Code",
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
                          "${(category.groupedTests ?? []).length + i + 1}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // const DataCell(
                      //   Center(child: Text(" - ", textAlign: TextAlign.center)),
                      // ),
                      DataCell(
                        Text(category.ungroupedTests?[i].test?.testCode ?? ""),
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
                                            hintText: "",
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
                                      //       hintText: "",
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
                                      hintText: "",
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
                                  "${category.ungroupedTests?[i].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.ungroupedTests?[i].appliedReferenceRange?.highValue.toString() ?? ""} ",
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
                                              onChanged: (v) {
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
                                              controller: category
                                                  .ungroupedTests![i]
                                                  .characteristics![j]
                                                  .lowvalue,
                                              hintText: "",
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
                                        //       hintText: "",
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
                                        hintText: "",
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
                              "${category.ungroupedTests?[i].characteristics?[j].appliedReferenceRange?.lowValue.toString() ?? ""} - ${category.ungroupedTests?[i].characteristics?[j].appliedReferenceRange?.highValue.toString() ?? ""} ",
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
