import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;
import 'package:labapp/models/caseModel.dart';
import 'package:labapp/models/doctor_model.dart';
import 'package:labapp/models/lab_center_model.dart';
import 'package:labapp/models/patient_response_model.dart';
import 'package:labapp/utils/app_config.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();

  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  Lab? selectedCenter;
  Doctor? selectedDoctor;
  String? selectedCaseStatus;
  String? selectedAmountStatus;

  final List<String> caseStatus = ["Final", "Pending", "Draft"];
  final List<String> amountStatus = ["Paid", "Unpaid", "Partially Paid"];

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
      fetchCases(pageKey, status: "All", controller: allPagingController);
    });

    newPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey, status: "New", controller: newPagingController);
    });

    finalPagingController.addPageRequestListener((pageKey) {
      fetchCases(pageKey, status: "Final", controller: finalPagingController);
    });

    signOffPagingController.addPageRequestListener((pageKey) {
      fetchCases(
        pageKey,
        status: "SignOff",
        controller: signOffPagingController,
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
  }) async {
    try {
      final query = searchController.text.trim();
      var url =
          "${AppConfig.baseUrl}/cases?search=$query${status == "All" ? "" : "&status=$status"}&page=$pageKey&limit=$_pageSize";

      if (startdateController.text.isNotEmpty) {
        url +=
            "&createdAtFrom=${DateTime.parse(startdateController.text).toIso8601String()}";
      }
      if (enddateController.text.isNotEmpty) {
        url +=
            "&createdAtTo=${DateTime.parse(enddateController.text).toIso8601String()}";
      }
      if (selectedCenter != null) {
        url += "&center=${selectedCenter?.id}";
      }
      if (selectedDoctor != null) {
        url += "&referringDoctor=${selectedDoctor?.id}";
      }

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
