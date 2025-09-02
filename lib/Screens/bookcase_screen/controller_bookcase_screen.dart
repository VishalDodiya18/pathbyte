import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/models/doctor_model.dart';
import 'package:labapp/models/lab_center_model.dart';
import 'package:labapp/models/test_model.dart';
import 'package:labapp/utils/app_config.dart';
import 'package:phone_form_field/phone_form_field.dart';

class BookCaseController extends GetxController {
  TextEditingController caseIdController = TextEditingController(
    text: '#123345',
  );
  final TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController(
    text: DateTime.now().toIso8601String(),
  );
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final TextEditingController yearsController = TextEditingController(
    text: '24',
  );
  final TextEditingController monthsController = TextEditingController(
    text: '0',
  );
  final TextEditingController daysController = TextEditingController(text: '0');
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var phoneNumber = PhoneNumber.parse('+91').obs;
  Doctor? selectedDoctor;
  Lab? selectedCenter;

  void updatePhone(PhoneNumber number) {
    phoneNumber.value = number;
    print("Updated phone number: $number");
  }

  List<String> referreingDocList = [
    'Dr. Parul Singhal',
    'Dr. Parul Patel',
    'Dr. Mayank Patel',
    'Dr. Sanjay Dutt',
    'Dr. Om Shah',
  ];
  RxString selectedReferringDoc = 'Dr. Parul Singhal'.obs;

  List<String> mrmissList = ['Mr.', 'Mrs.', 'Ms.', 'Dr.'];
  RxString selectedTitle = 'Mr.'.obs;
  List<String> sexList = ['Male', 'Female', 'Other'];
  RxString selectedSex = 'Male'.obs;
  List<String> modeList = ['Cash', 'UPI', 'Bank'];
  RxString selectedMode = 'Cash'.obs;
  static const _pageSize = 10;

  final PagingController<int, Test> pagingController = PagingController(
    firstPageKey: 1,
  );
  RxList<Test> selectedTests = <Test>[].obs;
  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchTests(pageKey);
    });
    super.onInit();
  }

  void toggleSelection(Test test) {
    if (selectedTests.any((element) => element.id == test.id)) {
      selectedTests.removeWhere((element) => element.id == test.id);
    } else {
      selectedTests.add(test);
    }
    update();
  }

  Future<void> fetchTests(int pageKey) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConfig.baseUrl}/tests?page=$pageKey&limit=$_pageSize"),
      );

      final data = jsonDecode(response.body);
      log(data.toString());
      GetAllTestModel getAllTestModel = GetAllTestModel.fromJson(data);
      final List<Test> newItems = getAllTestModel.data?.tests ?? [];

      final pagination = data['data']['pagination'];

      final isLastPage =
          pageKey >= (getAllTestModel.data?.pagination?.totalPages ?? 0);

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      log(error.toString());
      pagingController.error = error;
    }
  }
}
