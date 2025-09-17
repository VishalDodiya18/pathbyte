// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;
import 'package:pathbyte/models/caseModel.dart';
import 'package:pathbyte/models/case_list_model.dart';
import 'package:pathbyte/models/doctor_model.dart';
import 'package:pathbyte/models/lab_center_model.dart';
import 'package:pathbyte/models/patient_response_model.dart';
import 'package:pathbyte/utils/app_config.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  DateTimeRange? dates;
  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  Lab? selectedCenter;
  Doctor? selectedDoctor;
  String? selectedCaseStatus;
  String? selectedAmountStatus;

  CaseListModel? allCaselistmodel;

  CaseListModel? newCaselistmodel;
  CaseListModel? finalCaselistmodel;
  CaseListModel? signoffCaselistmodel;

  final List<String> caseStatus = ["New", "Final", "InProgress", "SignOff"];
  final List<String> amountStatus = ["Paid", "Unpaid", "PartiallyPaid"];

  static const int _pageSize = 10;

  /// Paging controllers
  final PagingController<int, Lab> labPagingController = PagingController(
    firstPageKey: 1,
  );

  final PagingController<int, Doctor> doctorPagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, Patient> patientPagingController =
      PagingController(firstPageKey: 1);
  TextEditingController patientSearchController = TextEditingController();

  /// Cases controllers
  final PagingController<int, Cases> allPagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, Cases> newPagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, Cases> finalPagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, Cases> signOffPagingController = PagingController(
    firstPageKey: 1,
  );

  final TextEditingController doctorsearch = TextEditingController();
  final TextEditingController labsearch = TextEditingController();
  OnRefresh() {
    allPagingController.refresh();
    newPagingController.refresh();
    finalPagingController.refresh();
    signOffPagingController.refresh();

    doctorPagingController.refresh();
    labPagingController.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    patientPagingController.addPageRequestListener((pageKey) {
      fetchPatients(pageKey, controller: patientPagingController);
    });

    /// Doctors pagination
    doctorPagingController.addPageRequestListener((pageKey) {
      fetchDoctors(
        pageKey,
        controller: doctorPagingController,
        search: doctorsearch,
      );
    });

    /// Labs pagination
    labPagingController.addPageRequestListener((pageKey) {
      fetchLabCenters(
        pageKey,
        controller: labPagingController,
        search: labsearch,
      );
    });

    /// Cases pagination
    allPagingController.addPageRequestListener((pageKey) {
      fetchCases(
        pageKey,
        status: "All",
        controller: allPagingController,
        caseListModel: allCaselistmodel,
      );
    });

    newPagingController.addPageRequestListener((pageKey) {
      fetchCases(
        pageKey,
        status: "New",
        controller: newPagingController,
        caseListModel: newCaselistmodel,
      );
    });

    finalPagingController.addPageRequestListener((pageKey) {
      fetchCases(
        pageKey,
        status: "Final",
        controller: finalPagingController,
        caseListModel: finalCaselistmodel,
      );
    });

    signOffPagingController.addPageRequestListener((pageKey) {
      fetchCases(
        pageKey,
        status: "SignOff",
        controller: signOffPagingController,
        caseListModel: signoffCaselistmodel,
      );
    });
  }

  Future<void> fetchPatients(
    int pageKey, {
    required PagingController<int, Patient> controller,
  }) async {
    try {
      final query = patientSearchController.text.trim();

      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseUrl}/patients?page=$pageKey&limit=$_pageSize${query.isEmpty ? "" : "&search=$query"}",
        ),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );

      if (response.statusCode == 200) {
        final data = PatientResponseModel.fromJson(jsonDecode(response.body));
        final patients = data.data?.patients ?? [];

        final isLastPage = !(data.data?.pagination?.hasNextPage ?? false);
        if (isLastPage) {
          controller.appendLastPage(patients);
        } else {
          controller.appendPage(patients, pageKey + 1);
        }
      } else {
        controller.error = "Failed: ${response.statusCode}";
      }
    } catch (e) {
      controller.error = e.toString();
    }
  }

  /// Doctors with pagination
  Future<void> fetchDoctors(
    int pageKey, {
    required PagingController<int, Doctor> controller,
    TextEditingController? search,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseUrl}/doctors?page=$pageKey&limit=$_pageSize${search != null && search.text.trim().isNotEmpty ? "&search=${search.text}" : ""}",
        ),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final doctorResponse = DoctorResponse.fromJson(jsonData);

        final doctorsList = doctorResponse.data.doctors;

        final isLastPage = doctorsList.length < _pageSize;
        if (isLastPage) {
          controller.appendLastPage(doctorsList);
        } else {
          controller.appendPage(doctorsList, pageKey + 1);
        }
      } else {
        controller.error = "Failed: ${response.statusCode}";
      }
    } catch (e) {
      controller.error = e.toString();
    }
  }

  /// Lab Centers with pagination
  Future<void> fetchLabCenters(
    int pageKey, {
    required PagingController<int, Lab> controller,
    TextEditingController? search,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseUrl}/lab-centers?page=$pageKey&limit=$_pageSize${search != null && search.text.trim().isNotEmpty ? "&search=${search.text}" : ""}",
        ),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final labResponse = LabCenterResponse.fromJson(jsonData);

        final labsList = labResponse.data.labs;

        final isLastPage = labsList.length < _pageSize;
        if (isLastPage) {
          controller.appendLastPage(labsList);
        } else {
          controller.appendPage(labsList, pageKey + 1);
        }
      } else {
        controller.error = "Failed: ${response.statusCode}";
      }
    } catch (e) {
      controller.error = e.toString();
    }
  }

  /// Cases (already paginated)
  Future<void> fetchCases(
    int pageKey, {
    required String status,
    required PagingController<int, Cases> controller,
    required CaseListModel? caseListModel,
  }) async {
    try {
      final query = searchController.text.trim();
      var url =
          "${AppConfig.baseUrl}/cases?search=$query${status == "All" ? "" : "&status=$status"}&page=$pageKey&limit=$_pageSize";

      if (dates != null) {
        url += "&createdAtFrom=${dates?.start.toIso8601String()}";
        url += "&createdAtTo=${dates?.end.toIso8601String()}";
      }
      if (selectedCenter != null) {
        url += "&center=${selectedCenter?.id}";
      }
      if (selectedDoctor != null) {
        url += "&referringDoctor=${selectedDoctor?.id}";
      }
      if (selectedAmountStatus != null) {
        url += "&amountStatus=$selectedAmountStatus";
      }
      if (selectedCaseStatus != null) {
        url += "&status=$selectedCaseStatus";
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (status == "All")
          allCaselistmodel = CaseListModel.fromJson(data);
        else if (status == "New")
          newCaselistmodel = CaseListModel.fromJson(data);
        else if (status == "Final")
          finalCaselistmodel = CaseListModel.fromJson(data);
        else
          signoffCaselistmodel = CaseListModel.fromJson(data);

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
      log(e.toString());
      controller.error = e;
    } finally {
      update();
    }
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
    doctorPagingController.dispose();
    labPagingController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
