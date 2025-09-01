import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/models/caseModel.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();

  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  String? selectedCenter;
  String? selectedDoctor;
  String? selectedCaseStatus;
  String? selectedAmountStatus;

  final List<String> centers = ["Main Lab", "Branch A", "Branch B"];
  final List<String> doctors = ["Dr. Parul Singhal", "Dr. XYZ", "Dr. ABC"];
  final List<String> caseStatus = ["Final", "Pending", "Draft"];
  final List<String> amountStatus = ["Paid", "Unpaid", "Partially Paid"];

  static const int _pageSize = 10;

  // har status ke liye alag PagingController
  final PagingController<int, CaseModel> allPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, CaseModel> newPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, CaseModel> finalPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, CaseModel> signOffPagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);

    allPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey, status: "All", controller: allPagingController);
    });

    newPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey, status: "New", controller: newPagingController);
    });

    finalPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey, status: "Final", controller: finalPagingController);
    });

    signOffPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey,
          status: "SignOff", controller: signOffPagingController);
    });
  }

  Future<void> fetchCases(int pageKey,
      {required String status,
      required PagingController<int, CaseModel> controller}) async {
    // try {
    final query = searchController.text.trim();
    final url =
        "https://pathlabapi.kilobyte.live/api/v1/cases?search=$query${status == "All" ? "" : "&status=$status"}&page=$pageKey&limit=$_pageSize";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List casesJson = data ?? [];
      final cases = casesJson.map((e) => CaseModel.fromJson(e)).toList();

      final isLastPage = cases.length < _pageSize;
      if (isLastPage) {
        controller.appendLastPage(cases);
      } else {
        final nextPageKey = pageKey + 1;
        controller.appendPage(cases, nextPageKey);
      }
    } else {
      controller.error = "Error: ${response.statusCode}";
    }
    // } catch (e) {
    //   log(e.toString());
    //   controller.error = e;
    // }
  }

  void setTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    allPagingController.dispose();
    newPagingController.dispose();
    finalPagingController.dispose();
    signOffPagingController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
