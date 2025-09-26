// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathbyte/Constants/extensions.dart';
import 'package:pathbyte/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:pathbyte/models/group_test_model.dart';
import 'package:pathbyte/models/test_model.dart';

class SelectedTestsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookCaseController>(
      builder: (controller) {
        final List<Test> tests = (controller.selectedTests);
        final List<Group> groptests = (controller.selectedGroupTests);

        if (tests.isEmpty) {
          return const Center(child: Text("No tests selected"));
        }

        return SingleChildScrollView(
          child: Table(
            border: TableBorder.all(width: 0.5, color: Colors.grey.shade400),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: IntrinsicColumnWidth(), // Code
              1: FlexColumnWidth(), // Test Name (expand)
              2: IntrinsicColumnWidth(), // R.D.
              3: IntrinsicColumnWidth(), // Price
            },
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade200),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                    child: Text(
                      "Code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                    child: Text(
                      "Test Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                    child: Text(
                      "R.D.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
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
                      child: Text("${test.name ?? ""}"),
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
                final maxReportingDays = (group.tests ?? [])
                    .map((e) => e.reportingDays ?? 0)
                    .fold<int>(0, (a, b) => a > b ? a : b);

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
                      child: Text(
                        "${group.name ?? ""} (${(group.tests ?? []).length})",
                      ),
                    ),
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
          ),
        );
      },
    );
  }
}
