import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/models/caseModel.dart';
import 'package:labapp/models/case_details_model.dart';
import 'package:labapp/models/patient_details_model.dart';
import 'package:labapp/models/transactionResponse.dart';
import 'package:labapp/utils/app_config.dart';

class PatientDetailsController extends GetxController {
  Patient patient;
  PatientDetailsController({required this.patient});
  final PagingController<int, Cases> allPagingController = PagingController(
    firstPageKey: 1,
  );
  PatientDetailsModel? patientDetailsModel;
  static const int _pageSize = 10;
  RxBool isLoading = true.obs;
  final PagingController<int, Transaction> pagingController = PagingController(
    firstPageKey: 1,
  );
  final ScrollController scrollController = ScrollController();
  final List<Transaction> rows = [];
  bool isLoading2 = false;
  bool hasMore = true;
  int page = 1;
  final int pageSize = 20;

  @override
  void onInit() {
    allPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey, controller: allPagingController);
    });
    fetchpatient();
    _fetchTransactions(page);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          isLoading2 &&
          hasMore) {
        _fetchTransactions(page);
      }
    });
    pagingController.addPageRequestListener((pageKey) {
      _fetchTransactions(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchTransactions(int pageKey) async {
    isLoading2 = true;
    update();
    try {
      final url = Uri.parse(
        "${AppConfig.baseUrl}/transactions/?patientId=${patient.sId}&page=$pageKey&limit=$_pageSize",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = TransactionResponse.fromJson(jsonData);

        final newItems = data.data?.txs;
        final isLastPage = !(data.data?.pagination?.hasNextPage ?? false);

        page++;
        rows.addAll(newItems ?? []);
        if (isLastPage) {
          hasMore = false;
        }
        isLoading2 = false;
        update();
      } else {}
    } catch (error) {}
  }

  Future<void> fetchpatient() async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/patients/${patient.sId}"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final caseResponse = PatientDetailsModel.fromJson(jsonData);

        patientDetailsModel = caseResponse;

        update();
      } else {
        Get.snackbar("Error", "Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCases(
    int pageKey, {
    required PagingController<int, Cases> controller,
  }) async {
    try {
      var url =
          "${AppConfig.baseUrl}/cases?page=$pageKey&limit=$_pageSize&patientId=${patient.sId}";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List casesJson = data["data"]["cases"] ?? [];
        final cases = casesJson.map((e) => Cases.fromJson(e)).toList();

        final isLastPage = cases.length < _pageSize;
        if (isLastPage) {
          controller.appendLastPage(cases.cast<Cases>());
        } else {
          controller.appendPage(cases.cast<Cases>(), pageKey + 1);
        }
      } else {
        controller.error = "Error: ${response.statusCode}";
      }
    } catch (e) {
      //log(e.toString());
      controller.error = e;
    }
  }
}
