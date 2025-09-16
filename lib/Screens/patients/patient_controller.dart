import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:Pathbyte/models/caseModel.dart';
import 'package:Pathbyte/models/patient_response_model.dart';
import 'package:Pathbyte/utils/app_config.dart';

class PatientController extends GetxController {
  final PagingController<int, Patient> patientPagingController =
      PagingController(firstPageKey: 1);
  TextEditingController patientSearchController = TextEditingController();
  static const int _pageSize = 10;
  PatientResponseModel? responseModel;
  @override
  void onInit() {
    patientPagingController.addPageRequestListener((pageKey) {
      fetchPatients(pageKey, controller: patientPagingController);
    });

    super.onInit();
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
        responseModel = PatientResponseModel.fromJson(
          jsonDecode(response.body),
        );
        final patients = responseModel?.data?.patients ?? [];

        final isLastPage =
            !(responseModel?.data?.pagination?.hasNextPage ?? false);
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
    } finally {
      update();
    }
  }
}
