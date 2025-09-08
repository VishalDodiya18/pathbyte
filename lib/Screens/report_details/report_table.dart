import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/models/report_details_model.dart';
import 'package:labapp/utils/app_color.dart';

class ReportTable extends StatelessWidget {
  Category category;
  ReportTable({required this.category});
  final List<Map<String, dynamic>> reports = [
    {
      "sno": "1.",
      "test": "Haemoglobin",
      "flag": "L",
      "value": "12",
      "unit": "g/dL",
      "ref": "13-17",
    },
    {
      "sno": "2.",
      "test": "Haemoglobin",
      "flag": "",
      "value": "15",
      "unit": "g/dL",
      "ref": "13-17",
    },
    {
      "sno": "3.",
      "test": "Haemoglobin",
      "flag": "H",
      "value": "18",
      "unit": "g/dL",
      "ref": "13-17",
    },
    {
      "sno": "4.",
      "test": "Haemoglobin",
      "flag": "",
      "value": "15",
      "unit": "g/dL",
      "ref": "13-17",
    },
    {
      "sno": "5.",
      "test": "Haemoglobin",
      "flag": "L",
      "value": "12",
      "unit": "g/dL",
      "ref": "13-17",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          category.name ?? "",
          style: TextStyle(
            color: Color(0xff0A1B39),

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
        const SizedBox(height: 10),

        /// DataTable
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
              DataColumn(
                label: Text(
                  "Group Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
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
              for (int i = 0; i < (category.ungroupedTests ?? []).length; i++)
                DataRow(
                  cells: [
                    DataCell(Text("${i + 1}", textAlign: TextAlign.center)),
                    DataCell(
                      Center(child: Text(" - ", textAlign: TextAlign.center)),
                    ),
                    DataCell(
                      Text(category.ungroupedTests?[i].test?.name ?? ""),
                    ),
                    DataCell(
                      Row(
                        children: [
                          // if (row["flag"].toString().isNotEmpty)
                          // SizedBox(
                          //   width: 20.0,
                          //   child: Text(
                          //     row["flag"],
                          //     style: const TextStyle(
                          //       color: Colors.red,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: TextFieldConstant(
                              contentPadding: EdgeInsets.all(10.0),
                              fillColor: Color(0xffEEEEEE),
                              controller: category.ungroupedTests![i].value,
                              hintText: "",
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(category.ungroupedTests?[i].unit ?? "")),
                    DataCell(
                      Text(
                        "${category.ungroupedTests?[i].appliedReferenceRange?.lowValue ?? ""} - ${category.ungroupedTests?[i].appliedReferenceRange?.highValue ?? ""} ",
                      ),
                    ),
                  ],
                ),

              for (int i = 0; i < (category.groupedTests ?? []).length; i++)
                for (
                  int j = 0;
                  j < (category.groupedTests?[i].caseTests ?? []).length;
                  j++
                )
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          j == 0
                              ? "${(category.ungroupedTests ?? []).length + i + 1}"
                              : "",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            j == 0
                                ? (category.groupedTests?[i].name ?? "")
                                : " - ",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          category.groupedTests?[i].caseTests?[j].test?.name ??
                              "",
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            // if (row["flag"].toString().isNotEmpty)
                            // SizedBox(
                            //   width: 20.0,
                            //   child: Text(
                            //     row["flag"],
                            //     style: const TextStyle(
                            //       color: Colors.red,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: TextFieldConstant(
                                contentPadding: EdgeInsets.all(10.0),
                                fillColor: Color(0xffEEEEEE),
                                controller: category
                                    .groupedTests![i]
                                    .caseTests![j]
                                    .value,
                                hintText: "",
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          category.groupedTests![i].caseTests![j].unit ?? "",
                        ),
                      ),
                      DataCell(
                        Text(
                          "${category.groupedTests![i].caseTests![j].appliedReferenceRange?.lowValue ?? ""} - ${category.groupedTests![i].caseTests![j].appliedReferenceRange?.highValue ?? ""} ",
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
