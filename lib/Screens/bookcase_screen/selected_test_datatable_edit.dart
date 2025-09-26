import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathbyte/Constants/extensions.dart';
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

        return Table(
          border: TableBorder.all(width: 0.5, color: Colors.grey.shade400),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: IntrinsicColumnWidth(), // Group Name
            1: FlexColumnWidth(), // Code
            2: IntrinsicColumnWidth(), // Test Name (expandable)
            3: IntrinsicColumnWidth(), // R.D.
          },
          children: [
            // Header row
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: const [
                // Padding(
                //   padding: EdgeInsets.all(4.0),
                //   child: Text(
                //     "Group Name",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Code",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Test Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "R.D.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            // Individual tests rows
            ...tests.map((test) {
              return TableRow(
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.all(4.0),
                  //   child: Center(
                  //     child: Text(" - ", textAlign: TextAlign.center),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text(test.testCode ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text(test.name ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text((test.reportingDays ?? 1).toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text("₹${test.price}"),
                  ),
                ],
              );
            }).toList(),

            // Group tests rows
            ...groptests.map((group) {
              final testsInGroup = group.tests ?? [];
              final maxReportingDays = testsInGroup.isEmpty
                  ? 1
                  : testsInGroup
                        .map((e) => e.reportingDays ?? 0)
                        .reduce((a, b) => a > b ? a : b);

              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text(group.groupCode ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text("${group.name ?? ""} (${testsInGroup.length})"),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //   horizontal: 5.0,
                  //   vertical: 2,
                  // ),
                  //   child: Text(
                  //     testsInGroup.map((e) => e.name ?? "").join(" , "),
                  //     softWrap: true,
                  //     overflow: TextOverflow.visible,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text(maxReportingDays.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2,
                    ),
                    child: Text("${formatIndianCurrency(group.price ?? 0)}"),
                  ),
                ],
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
