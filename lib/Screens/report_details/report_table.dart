import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/utils/app_color.dart';

class ReportTable extends StatelessWidget {
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
          "Haematology",
          style: TextStyle(
            color: Color(0xff0A1B39),

            fontSize: 14.h,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 2,
          width: 120,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: AppColor.primary,
        ),
        Text(
          "Complete Blood Count (CBC)",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.h,
            color: Color(0xff0A1B39),
          ),
        ),
        const SizedBox(height: 16),

        /// DataTable
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columnSpacing: 30,
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
            rows: reports.map((row) {
              return DataRow(
                cells: [
                  DataCell(Text(row["sno"])),
                  DataCell(Text(row["test"])),
                  DataCell(
                    Row(
                      children: [
                        // if (row["flag"].toString().isNotEmpty)
                        SizedBox(
                          width: 20.0,
                          child: Text(
                            row["flag"],
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: TextFieldConstant(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: Color(0xffEEEEEE),
                            controller: TextEditingController(
                              text: row["value"],
                            ),
                            hintText: "",
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text(row["unit"])),
                  DataCell(Text(row["ref"])),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
