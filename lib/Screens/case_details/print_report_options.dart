import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/helper/helpers.dart';
import 'package:pathbyte/utils/app_color.dart';

class PrintReportOptions extends StatelessWidget {
  const PrintReportOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CaseDetailsContoller>(
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            appBar: CustomAppBar(title: "Print Report Options"),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.isreportshareing.value
                  ? SizedBox()
                  : elevatedButton(
                      title: "Print Selected Tests",
                      onPressed: () {
                        controller.fetchAndPrintHtml();
                      },
                    ),
            ),
            body:
                controller.reporting.value || controller.isreportshareing.value
                ? const Center(child: CircularProgressIndicator())
                : controller.reporting.isFalse &&
                      controller.reportDetailsModel == null
                ? Center(
                    child: Text(
                      "Report Detail Not Found",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : PopScope(
                    canPop: !controller.isLoading.value,

                    child: IgnorePointer(
                      ignoring: controller.isLoading.value,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            border: TableBorder.all(
                              width: 0.5,
                              color: Colors.grey.shade400,
                            ),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: const {
                              0: FlexColumnWidth(),
                              1: IntrinsicColumnWidth(), // Code
                              2: IntrinsicColumnWidth(), // R.D.
                              3: IntrinsicColumnWidth(), // Price
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      "Test Name",

                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "New\nPage",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                          width: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller.isnew,
                                            onChanged: (value) {
                                              controller.isnew = value!;
                                              controller.isAllCheck(
                                                value!,
                                                isnewpage: T,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Foot\nNote",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                          width: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller.isfootnote,
                                            onChanged: (value) {
                                              controller.isfootnote = value!;

                                              controller.isAllCheck(
                                                value!,
                                                isfootnote: T,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 5,
                                    ),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Select",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                            width: 20.0,
                                            child: Checkbox(
                                              activeColor: AppColor.primary,
                                              value: controller.isselect,
                                              onChanged: (value) {
                                                controller.isselect = value!;

                                                controller.isAllCheck(
                                                  value!,
                                                  isselect: T,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              for (
                                int i = 0;
                                i <
                                    (controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories ??
                                            [])
                                        .length;
                                i++
                              ) ...[
                                for (
                                  int j = 0;
                                  j <
                                      (controller
                                                  .reportDetailsModel
                                                  ?.data
                                                  ?.reportdetail
                                                  ?.categories?[i]
                                                  .groupedTests ??
                                              [])
                                          .length;
                                  j++
                                ) ...[
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          controller
                                                  .reportDetailsModel
                                                  ?.data
                                                  ?.reportdetail
                                                  ?.categories?[i]
                                                  .groupedTests?[j]
                                                  .name ??
                                              "",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories?[i]
                                                .groupedTests?[j]
                                                .isnewpage,
                                            onChanged: (value) {
                                              controller
                                                      .reportDetailsModel
                                                      ?.data
                                                      ?.reportdetail
                                                      ?.categories?[i]
                                                      .groupedTests?[j]
                                                      .isnewpage =
                                                  !(controller
                                                          .reportDetailsModel
                                                          ?.data
                                                          ?.reportdetail
                                                          ?.categories?[i]
                                                          .groupedTests?[j]
                                                          .isnewpage ??
                                                      false);
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories?[i]
                                                .groupedTests?[j]
                                                .isfootnote,
                                            onChanged: (value) {
                                              controller
                                                      .reportDetailsModel
                                                      ?.data
                                                      ?.reportdetail
                                                      ?.categories?[i]
                                                      .groupedTests?[j]
                                                      .isfootnote =
                                                  !(controller
                                                          .reportDetailsModel
                                                          ?.data
                                                          ?.reportdetail
                                                          ?.categories?[i]
                                                          .groupedTests?[j]
                                                          .isfootnote ??
                                                      false);
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories?[i]
                                                .groupedTests?[j]
                                                .isSelect,
                                            onChanged: (value) {
                                              controller
                                                      .reportDetailsModel
                                                      ?.data
                                                      ?.reportdetail
                                                      ?.categories?[i]
                                                      .groupedTests?[j]
                                                      .isSelect =
                                                  !(controller
                                                          .reportDetailsModel
                                                          ?.data
                                                          ?.reportdetail
                                                          ?.categories?[i]
                                                          .groupedTests?[j]
                                                          .isSelect ??
                                                      false);
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],

                                for (
                                  int l = 0;
                                  l <
                                      (controller
                                                  .reportDetailsModel
                                                  ?.data
                                                  ?.reportdetail
                                                  ?.categories?[i]
                                                  .ungroupedTests ??
                                              [])
                                          .length;
                                  l++
                                ) ...[
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: Text(
                                          controller
                                                  .reportDetailsModel
                                                  ?.data
                                                  ?.reportdetail
                                                  ?.categories?[i]
                                                  .ungroupedTests?[l]
                                                  .test
                                                  ?.name ??
                                              "",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories?[i]
                                                .ungroupedTests?[l]
                                                .isnewpage,
                                            onChanged: (value) {
                                              controller
                                                      .reportDetailsModel
                                                      ?.data
                                                      ?.reportdetail
                                                      ?.categories?[i]
                                                      .ungroupedTests?[l]
                                                      .isnewpage =
                                                  !(controller
                                                          .reportDetailsModel
                                                          ?.data
                                                          ?.reportdetail
                                                          ?.categories?[i]
                                                          .ungroupedTests?[l]
                                                          .isnewpage ??
                                                      false);
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories?[i]
                                                .ungroupedTests?[l]
                                                .isfootnote,
                                            onChanged: (value) {
                                              controller
                                                      .reportDetailsModel
                                                      ?.data
                                                      ?.reportdetail
                                                      ?.categories?[i]
                                                      .ungroupedTests?[l]
                                                      .isfootnote =
                                                  !(controller
                                                          .reportDetailsModel
                                                          ?.data
                                                          ?.reportdetail
                                                          ?.categories?[i]
                                                          .ungroupedTests?[l]
                                                          .isfootnote ??
                                                      false);
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 5,
                                        ),
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: Checkbox(
                                            activeColor: AppColor.primary,
                                            value: controller
                                                .reportDetailsModel
                                                ?.data
                                                ?.reportdetail
                                                ?.categories?[i]
                                                .ungroupedTests?[l]
                                                .isSelect,
                                            onChanged: (value) {
                                              controller
                                                      .reportDetailsModel
                                                      ?.data
                                                      ?.reportdetail
                                                      ?.categories?[i]
                                                      .ungroupedTests?[l]
                                                      .isSelect =
                                                  !(controller
                                                          .reportDetailsModel
                                                          ?.data
                                                          ?.reportdetail
                                                          ?.categories?[i]
                                                          .ungroupedTests?[l]
                                                          .isSelect ??
                                                      false);
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
      },
    );
  }
}
