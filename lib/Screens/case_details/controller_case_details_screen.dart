import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:pathbyte/Screens/case_details/report_table.dart';
import 'package:pathbyte/helper/helpers.dart';
import 'package:pathbyte/models/case_details_model.dart';
import 'package:pathbyte/models/group_test_model.dart';
import 'package:pathbyte/models/report_details_model.dart' as report;
import 'package:pathbyte/models/test_model.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class CaseDetailsContoller extends GetxController {
  var caseId;
  CaseDetailsContoller({required this.caseId});

  RxBool isLoading = true.obs;
  RxBool reporting = true.obs;
  RxBool printFootnote = false.obs;
  RxBool isreportshareing = F.obs;

  List<Test> selectedTests = [];
  List<Group> selectedGroupTests = [];
  bool isnew = false;
  bool isfootnote = T;
  bool isselect = T;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchCaseById();
    fetchreportCaseById();

    super.onInit();
  }

  CaseDetails? caseDetails;
  report.ReportDetailsModel? reportDetailsModel;
  Future<void> fetchCaseById() async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/cases/$caseId"),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 500) {
        Logout(message: data["message"] ?? "Your Session is expired");
        return;
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final caseResponse = CaseDetails.fromJson(jsonData["data"]["case"]);

        caseDetails = caseResponse;
        selectedTests = (caseDetails?.casetests ?? [])
            .where((element) => element.groupId == null)
            .map((e) => e.test!)
            .toList();

        selectedGroupTests = (caseDetails?.casetests ?? [])
            .where((e) => e.groupId != null && e.group != null)
            .map((e) => e.group!)
            .fold<Map<String, Group>>({}, (map, group) {
              map[group.groupId!] = group;
              return map;
            })
            .values
            .toList()
            .cast<Group>();
        selectedGroupTests.forEach((element) {
          element.tests = (caseDetails?.casetests ?? [])
              .where((e) => e.groupId == element.id)
              .map((e) => e.test!)
              .toList();
        });
        update();
      } else {
        // Get.snackbar(
        //   "Error", "Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<String> fetchHtml() async {
    isreportshareing(true);
    try {
      final url = Uri.parse("${AppConfig.baseUrl}/cases/$caseId/html");
      // Build body map
      final Map<String, dynamic> requestBody = {};

      // Categories → groupedTests → caseTests
      for (final category
          in reportDetailsModel?.data?.reportdetail?.categories ?? []) {
        for (final grouped in category.groupedTests ?? []) {
          for (final caseTest in grouped.caseTests ?? []) {
            final id = caseTest.id ?? "";
            if (id.isNotEmpty) {
              requestBody[id] = {
                "printFootnote": grouped.isfootnote ? true : false,
                "newPage": grouped.isnewpage ? true : false,
                "select": grouped.isSelect ? true : false,
              };
            }
          }
        }

        // Categories → ungroupedTests
        for (final ungrouped in category.ungroupedTests ?? []) {
          final id = ungrouped.id ?? "";
          if (id.isNotEmpty) {
            requestBody[id] = {
              "printFootnote": ungrouped.isfootnote,
              "newPage": ungrouped.isnewpage,
              "select": ungrouped.isSelect,
            };
          }
        }
      }
      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 500) {
        final data = jsonDecode(response.body);
        Logout(message: data["message"] ?? "Your Session is expired");
        return "";
      }
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Failed to load HTML");
      }
    } catch (e) {
      isreportshareing(false);
      throw Exception("Failed to load HTML");
    }
  }

  Future<void> fetchAndPrintHtml() async {
    isreportshareing(true);
    try {
      // 1. HTML fetch करो
      final htmlContent = await fetchHtml();

      // 2. Print dialog open करो
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          // HTML को convert करके system print dialog को भेजना
          final pdfBytes = await Printing.convertHtml(
            format: format,
            html: htmlContent,
          );
          return pdfBytes;
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isreportshareing(false);
    }
  }

  Future<void> downloadAndSharePdf() async {
    isreportshareing(T);
    try {
      final htmlContent = await fetchHtml();
      final _flutterNativeHtmlToPdfPlugin = FlutterNativeHtmlToPdf();
      Directory appDocDir = await getTemporaryDirectory();

      final generatedPdfFile = await _flutterNativeHtmlToPdfPlugin
          .convertHtmlToPdf(
            html: htmlContent,
            targetDirectory: appDocDir.path,
            targetName: "${caseDetails?.caseId}_Report",
          );

      await SharePlus.instance.share(
        ShareParams(files: [XFile(generatedPdfFile!.path)]),
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isreportshareing(F);
    }
  }

  Future<void> fetchreportCaseById() async {
    try {
      reporting(true);

      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/case-tests/$caseId"),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 500) {
        Logout(message: data["message"] ?? "Your Session is expired");
        return;
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final caseResponse = report.ReportDetailsModel.fromJson(jsonData);
        //log(jsonData.toString());
        reportDetailsModel = caseResponse;

        update();
      } else {
        // Get.snackbar(
        //   "Error", "Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      //log(e.toString());
      // Get.snackbar("Exception", e.toString());
    } finally {
      reporting(false);
      update();
    }
  }

  CreateReportResult({isdraft = true}) async {
    reporting.value = true;
    List<report.Category> category =
        reportDetailsModel?.data?.reportdetail?.categories ?? [];
    try {
      final url = Uri.parse("${AppConfig.baseUrl}/case-tests/$caseId");

      final body = {
        "status": isdraft ? "InProgress" : "Final",
        "updates": [
          for (int i = 0; i < category.length; i++) ...[
            for (
              int j = 0;
              j < (category[i].groupedTests ?? []).length;
              j++
            ) ...[
              for (
                int k = 0;
                k < (category[i].groupedTests?[j].caseTests ?? []).length;
                k++
              )
                {
                  "testId": category[i].groupedTests?[j].caseTests?[k].test?.id,
                  "groupId": category[i].groupedTests?[j].id,
                  if ((category[i]
                              .groupedTests?[j]
                              .caseTests?[k]
                              .characteristics ??
                          [])
                      .isEmpty)
                    if ((category[i]
                                    .groupedTests?[j]
                                    .caseTests?[k]
                                    .test
                                    ?.testType ??
                                "")
                            .toLowerCase() ==
                        "numeric")
                      "numberValue":
                          (category[i]
                                      .groupedTests?[j]
                                      .caseTests?[k]
                                      .lowvalue
                                      .text ??
                                  "")
                              .isEmpty
                          ? null
                          : num.parse(
                              category[i]
                                      .groupedTests?[j]
                                      .caseTests?[k]
                                      .lowvalue
                                      .text ??
                                  "",
                            )
                    else
                      "stringValue":
                          category[i]
                              .groupedTests![j]
                              .caseTests![k]
                              .lowvalue
                              .text
                              .isEmpty
                          ? null
                          : category[i]
                                .groupedTests![j]
                                .caseTests![k]
                                .lowvalue
                                .text,

                  if ((category[i]
                              .groupedTests?[j]
                              .caseTests?[k]
                              .characteristics ??
                          [])
                      .isNotEmpty)
                    "characteristics":
                        (category[i]
                                    .groupedTests?[j]
                                    .caseTests?[k]
                                    .characteristics ??
                                [])
                            .isEmpty
                        ? []
                        : (category[i]
                                      .groupedTests?[j]
                                      .caseTests?[k]
                                      .characteristics ??
                                  [])
                              .map(
                                (e) => {
                                  "name": e.name ?? "",
                                  "id": e.sId,
                                  if ((e.charType ?? "").toLowerCase() ==
                                      "numeric")
                                    "numberValue": e.lowvalue.text.isEmpty
                                        ? null
                                        : isValidMathExpression(e.formula ?? "")
                                        ? evaluateCharacteristicValue(
                                            e,
                                            category[i]
                                                    .groupedTests?[j]
                                                    .caseTests?[k]
                                                    .characteristics ??
                                                [],
                                          ).toString()
                                        : num.parse(e.lowvalue.text)
                                  else
                                    "stringValue": e.lowvalue.text.isEmpty
                                        ? null
                                        : e.lowvalue.text,
                                },
                              )
                              .toList(),
                },
            ],
            for (int j = 0; j < (category[i].ungroupedTests ?? []).length; j++)
              {
                "testId": category[i].ungroupedTests?[j].test?.id,
                if ((category[i].ungroupedTests?[j].characteristics ?? [])
                    .isEmpty)
                  if ((category[i].ungroupedTests?[j].test?.testType ?? "")
                          .toLowerCase() ==
                      "numeric")
                    "numberValue":
                        (category[i].ungroupedTests?[j].lowvalue.text ?? "")
                            .isEmpty
                        ? null
                        : num.parse(
                            category[i].ungroupedTests?[j].lowvalue.text ?? "0",
                            // "0",
                          )
                  else
                    "stringValue":
                        (category[i].ungroupedTests?[j].lowvalue.text ?? "")
                            .isEmpty
                        ? null
                        : category[i].ungroupedTests?[j].lowvalue.text,

                // "value": category[i].ungroupedTests?[j].lowvalue.text,
                if ((category[i].ungroupedTests?[j].characteristics ?? [])
                    .isNotEmpty)
                  "characteristics":
                      (category[i].ungroupedTests?[j].characteristics ?? [])
                          .isEmpty
                      ? []
                      : (category[i].ungroupedTests?[j].characteristics ?? [])
                            .map(
                              (e) => {
                                "name": e.name ?? "",
                                "id": e.sId,
                                if ((e.charType ?? "").toLowerCase() ==
                                    "numeric")
                                  "numberValue": e.lowvalue.text.isEmpty
                                      ? null
                                      : isValidMathExpression(e.formula ?? "")
                                      ? evaluateCharacteristicValue(
                                          e,
                                          category[i]
                                                  .ungroupedTests?[j]
                                                  .characteristics ??
                                              [],
                                        ).toString()
                                      : num.parse(e.lowvalue.text)
                                else
                                  "stringValue": e.lowvalue.text.isEmpty
                                      ? null
                                      : e.lowvalue.text,
                              },
                            )
                            .toList(),
              },
          ],
        ],
      };
      // log(body.toString());
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConfig.Token}",
        },
        body: jsonEncode(body),
      );

      var model = jsonDecode(response.body);

      if (response.statusCode == 500) {
        Logout(message: model["message"] ?? "Your Session is expired");
        return;
      }
      if (response.statusCode == 200 && model["code"] == 200) {
        Get.back();
      } else {
        //log(model["message"]);
        Get.snackbar(
          "Error",
          model["message"] ?? "Case updation failed please try again",
          colorText: AppColor.whitecolor,

          backgroundColor: AppColor.redcolor,
        );
        reporting.value = false;

        return null;
      }
    } catch (e) {
      reporting.value = false;

      print("Exception: $e");
      return null;
    } finally {
      reporting.value = false;
    }
  }

  gettotalamount() {
    final List<Test> tests = (selectedTests).toList();
    final List<Group> groptests = (selectedGroupTests);

    return tests.isEmpty && groptests.isEmpty
        ? 0
        : tests.map((e) => e.price ?? 0).reduce((a, b) => a + b) +
              (groptests.isEmpty
                  ? 0
                  : groptests.map((e) => e.price ?? 0).reduce((a, b) => a + b));
  }

  gettotalwitdiscountamount() {
    return (gettotalamount() -
        (int.parse((caseDetails?.discountValue ?? 0).toString())));
  }

  gettotalwitdiscountwithrecivedamount() {
    return gettotalwitdiscountamount() -
        (((caseDetails?.transactions ?? []).isEmpty)
            ? 0
            : (caseDetails?.transactions ?? [])
                  .map((e) => e.amountGiven)
                  .reduce((a, b) => a + b));
  }

  isAllCheck(
    bool v, {
    bool isnewpage = false,
    bool isfootnote = false,
    bool isselect = false,
  }) {
    for (
      int i = 0;
      i < (reportDetailsModel?.data?.reportdetail?.categories ?? []).length;
      i++
    ) {
      for (
        int j = 0;
        j <
            (reportDetailsModel
                        ?.data
                        ?.reportdetail
                        ?.categories?[i]
                        .groupedTests ??
                    [])
                .length;
        j++
      ) {
        if (isnewpage) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .groupedTests?[j]
                  .isnewpage =
              v;
        }
        if (isfootnote) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .groupedTests?[j]
                  .isfootnote =
              v;
        }
        if (isselect) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .groupedTests?[j]
                  .isSelect =
              v;
        }
        for (
          int k = 0;
          k <
              (reportDetailsModel
                          ?.data
                          ?.reportdetail
                          ?.categories?[i]
                          .groupedTests?[j]
                          .caseTests ??
                      [])
                  .length;
          k++
        ) {
          if (isnewpage) {
            reportDetailsModel
                    ?.data
                    ?.reportdetail
                    ?.categories?[i]
                    .groupedTests?[j]
                    .caseTests?[k]
                    .isnewpage =
                v;
          }
          if (isfootnote) {
            reportDetailsModel
                    ?.data
                    ?.reportdetail
                    ?.categories?[i]
                    .groupedTests?[j]
                    .caseTests?[k]
                    .isfootnote =
                v;
          }
          if (isselect) {
            reportDetailsModel
                    ?.data
                    ?.reportdetail
                    ?.categories?[i]
                    .groupedTests?[j]
                    .caseTests?[k]
                    .isSelect =
                v;
          }
        }
      }
      for (
        int l = 0;
        l <
            (reportDetailsModel
                        ?.data
                        ?.reportdetail
                        ?.categories?[i]
                        .ungroupedTests ??
                    [])
                .length;
        l++
      ) {
        if (isnewpage) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .ungroupedTests?[l]
                  .isnewpage =
              v;
        }
        if (isfootnote) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .ungroupedTests?[l]
                  .isfootnote =
              v;
        }
        if (isselect) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .ungroupedTests?[l]
                  .isSelect =
              v;
        }
      }
    }
    update();
  }

  returnbody(
    bool v, {
    bool isnewpage = false,
    bool isfootnote = false,
    bool isselect = false,
  }) {
    for (
      int i = 0;
      i < (reportDetailsModel?.data?.reportdetail?.categories ?? []).length;
      i++
    ) {
      for (
        int j = 0;
        j <
            (reportDetailsModel
                        ?.data
                        ?.reportdetail
                        ?.categories?[i]
                        .groupedTests ??
                    [])
                .length;
        j++
      ) {
        for (
          int k = 0;
          k <
              (reportDetailsModel
                          ?.data
                          ?.reportdetail
                          ?.categories?[i]
                          .groupedTests?[j]
                          .caseTests ??
                      [])
                  .length;
          k++
        ) {
          if (isnewpage) {
            reportDetailsModel
                    ?.data
                    ?.reportdetail
                    ?.categories?[i]
                    .groupedTests?[j]
                    .caseTests?[k]
                    .isnewpage =
                v;
          }
          if (isfootnote) {
            reportDetailsModel
                    ?.data
                    ?.reportdetail
                    ?.categories?[i]
                    .groupedTests?[j]
                    .caseTests?[k]
                    .isfootnote =
                v;
          }
          if (isselect) {
            reportDetailsModel
                    ?.data
                    ?.reportdetail
                    ?.categories?[i]
                    .groupedTests?[j]
                    .caseTests?[k]
                    .isSelect =
                v;
          }
        }
      }
      for (
        int l = 0;
        l <
            (reportDetailsModel
                        ?.data
                        ?.reportdetail
                        ?.categories?[i]
                        .ungroupedTests ??
                    [])
                .length;
        l++
      ) {
        if (isnewpage) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .ungroupedTests?[l]
                  .isnewpage =
              v;
        }
        if (isfootnote) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .ungroupedTests?[l]
                  .isfootnote =
              v;
        }
        if (isselect) {
          reportDetailsModel
                  ?.data
                  ?.reportdetail
                  ?.categories?[i]
                  .ungroupedTests?[l]
                  .isSelect =
              v;
        }
      }
    }
    update();
  }

  String getFullAddress(Address? address) {
    if (address == null) return "";

    // Sirf non-empty fields select karenge
    final parts = [
      address.line1,
      address.line2,
      address.city,
      address.state,
      address.postalCode,
      address.country,
    ].where((e) => e != null && e.trim().isNotEmpty).toList();

    return parts.join(", ");
  }
}

extension CaseDetailsExtension on CaseDetails {
  /// Transactions ka total
  num get totalTransactionAmount {
    return transactions
            ?.map((t) => t.amountGiven ?? 0)
            .fold(0, (a, b) => (a ?? 0) + (b ?? 0)) ??
        0;
  }

  /// Remaining amount = totalAmount - transactions sum
  num get remainingAmount {
    final total = finalAmount ?? 0;
    return total - totalTransactionAmount;
  }
}
