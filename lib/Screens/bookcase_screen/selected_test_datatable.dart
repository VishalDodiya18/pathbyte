import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:labapp/models/test_model.dart';

class SelectedTestsTable extends StatelessWidget {
  final BookCaseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Test> tests = controller.selectedTests;

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
            DataColumn(label: Text("Test Code")),
            DataColumn(label: Text("Test Name")),
            DataColumn(label: Text("Report Days")),
            DataColumn(label: Text("Rate")),
            DataColumn(label: Text("Action")),
          ],
          rows: List.generate(tests.length, (index) {
            final test = tests[index];
            return DataRow(
              cells: [
                DataCell(Text("${index + 1}")),
                DataCell(Text(test.testId ?? "")),
                DataCell(Text(test.name ?? "")),
                DataCell(Text((test.reportingDays ?? 1).toString())),
                DataCell(Text("₹${test.price}/-")),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.toggleSelection(test);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
