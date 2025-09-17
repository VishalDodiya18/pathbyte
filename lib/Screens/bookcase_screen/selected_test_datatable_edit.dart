import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathbyte/Constants/extensions.dart';
import 'package:pathbyte/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:pathbyte/Screens/bookcase_screen/controller_bookcase_screen_edit.dart';
import 'package:pathbyte/models/group_test_model.dart';
import 'package:pathbyte/models/test_model.dart';

class EditSelectedTestsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditBookCaseController>(
      builder: (controller) {
        final List<Test> tests = (controller.selectedTests);
        final List<Group> groptests = (controller.selectedGroupTests);
        if (tests.isEmpty) {
          return const Center(child: Text("No tests selected"));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowHeight: 40,
            dataRowMinHeight: 4,

            dataRowMaxHeight: 36,

            headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
            border: TableBorder.all(width: 0.5, color: Colors.grey.shade400),

            columns: const [
              DataColumn(label: Text("S.No")),
              DataColumn(label: Text("Group Name")),
              DataColumn(label: Text("Code")),
              DataColumn(label: Text("Test Name")),
              DataColumn(label: Text("R.D.")),
              DataColumn(label: Text("Price")),
              // DataColumn(label: Text("Action")),
            ],
            rows: [
              ...List.generate(tests.length, (index) {
                final test = tests[index];
                return DataRow(
                  cells: [
                    // DataCell(Text("${index + 1}")),
                    DataCell(Text("${index + 1}")),
                    const DataCell(
                      Center(child: Text(" - ", textAlign: TextAlign.center)),
                    ),
                    DataCell(Text(test.testId ?? "")),
                    DataCell(Text(test.name ?? "")),
                    DataCell(Text((test.reportingDays ?? 1).toString())),
                    DataCell(Text("₹${test.price}/-")),
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

              for (int i = 0; i < (groptests ?? []).length; i++)
                DataRow(
                  cells: [
                    // DataCell(Text("${index + 1}")),
                    DataCell(Text("${tests.length + i + 1}")),
                    DataCell(Text(groptests[i].name ?? "")),
                    DataCell(Text(groptests[i].groupId ?? "")),
                    DataCell(
                      SizedBox(
                        child: Text(
                          (groptests[i].tests ?? [])
                              .map((e) => e.name ?? "")
                              .join(" , "),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        (groptests[i].tests ?? []).isEmpty
                            ? "1"
                            : (groptests[i].tests ?? [])
                                  .map((e) => e.reportingDays ?? 0)
                                  .reduce((a, b) => a > b ? a : b)
                                  .toString(),
                      ),
                    ),
                    DataCell(
                      Text(
                        "${formatIndianCurrency(groptests[i].price ?? 0)}/-",
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
          ),
        );
      },
    );
  }
}
