import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:labapp/models/case_details_model.dart';
import 'package:labapp/models/group_test_model.dart';
import 'package:labapp/models/report_details_model.dart' as report;
import 'package:labapp/models/test_model.dart';
import 'package:labapp/utils/app_config.dart';

class CaseDetailsContoller extends GetxController {
  var caseId;
  CaseDetailsContoller({required this.caseId});

  RxBool isLoading = true.obs;
  RxBool reporting = true.obs;

  List<Test> selectedTests = [];
  List<Group> selectedGroupTests = [];
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
      );

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

  Future<void> fetchreportCaseById() async {
    try {
      reporting(true);

      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/case-tests/$caseId"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final caseResponse = report.ReportDetailsModel.fromJson(jsonData);

        reportDetailsModel = caseResponse;

        update();
      } else {
        // Get.snackbar(
        //   "Error", "Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Get.snackbar("Exception", e.toString());
    } finally {
      reporting(false);
      update();
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
