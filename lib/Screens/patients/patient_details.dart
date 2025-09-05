import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:labapp/Constants/extensions.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/home_screen/widget_home_screen.dart';
import 'package:labapp/Screens/patients/patient_details_controller.dart';
import 'package:labapp/Screens/patients/patients.dart';
import 'package:labapp/models/case_details_model.dart';
import 'package:labapp/utils/app_color.dart';

class PatientDetails extends StatelessWidget {
  const PatientDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientDetailsController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(title: const Text("Patient Details")),
            body: controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : controller.isLoading.isFalse &&
                      controller.patientDetailsModel == null
                ? Center(
                    child: Text(
                      "Patient Detail Not Found",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: AppColor.whitecolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          child: Column(
                            children: [
                              buildHeaderCard(
                                context,
                                controller.patientDetailsModel?.data?.patient,
                                isedit: T,
                              ),
                              buildInfoCard(
                                controller.patientDetailsModel?.data?.patient,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        heightBox(10),

                        TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: const [
                            Tab(text: "Cases"),
                            Tab(text: "Transactions"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              HomeScreenWidget().tabbarWidget(4),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: controller.scrollController,
                                padding: EdgeInsets.all(15.0),
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
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        "ID",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Mode",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Date - Time",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: (controller.rows ?? []).map((tx) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(tx.transactionId ?? "")),

                                        // DataCell(Text(tx["receiver"]!)),
                                        DataCell(
                                          Row(
                                            children: [
                                              Text(
                                                formatIndianCurrency(
                                                  tx.amountGiven ?? 0,
                                                ),
                                              ),
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
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                side: BorderSide(
                                                  color: Colors.blue.shade400,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                              child: Text(
                                                (tx.mode ?? "").toUpperCase(),
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            DateFormat(
                                              "dd, MMM yyyy hh:mm a",
                                            ).format(
                                              tx.createdAt ??
                                                  DateTime.parse(
                                                    "2000-01-01T10:28:22.492Z",
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
