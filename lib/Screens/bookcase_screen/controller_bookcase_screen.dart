import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/Constants/extensions.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/models/caseModel.dart';
import 'package:labapp/models/doctor_model.dart' hide Address;
import 'package:labapp/models/group_test_model.dart';
import 'package:labapp/models/lab_center_model.dart';
import 'package:labapp/models/test_model.dart';
import 'package:labapp/utils/app_color.dart';
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
  TextEditingController address = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController recivedamount = TextEditingController();
  final TextEditingController yearsController = TextEditingController(
    text: '24',
  );
  final TextEditingController monthsController = TextEditingController(
    text: '0',
  );

  bool isLoading = false;
  final TextEditingController daysController = TextEditingController(text: '0');
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  PhoneController phoneNumber = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.IN, nsn: ""),
  );
  Doctor? selectedDoctor;
  Lab? selectedCenter;
  Patient? selectedpatient;

  List<String> mrmissList = ['Mr.', 'Mrs.', 'Ms.', 'Dr.'];
  RxString selectedTitle = 'Mr.'.obs;
  List<String> sexList = ['Male', 'Female', 'Other'];
  RxString selectedSex = 'Male'.obs;
  RxString selectedMode = 'Cash'.obs;
  static const _pageSize = 10;

  final PagingController<int, Test> pagingController = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, Group> grouptestController = PagingController(
    firstPageKey: 1,
  );
  TextEditingController searchcontrller = TextEditingController();
  List<Test> selectedTests = [];
  List<Group> selectedGroupTests = [];
  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchTests(pageKey);
    });
    grouptestController.addPageRequestListener((pageKey) {
      fetchGroupTests(pageKey);
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

  void toggleGroupSelection(Group test) {
    if (selectedGroupTests.any((element) => element.id == test.id)) {
      selectedGroupTests.removeWhere((element) => element.id == test.id);
    } else {
      selectedGroupTests.add(test);
    }
    update();
  }

  gettotalamount() {
    final List<Test> tests =
        (selectedTests +
                ((((selectedGroupTests.map(
                  (element) => (element.tests ?? []).toList(),
                )).toList()).expand((e) => e)).toList()))
            .toList();
    return tests.isEmpty
        ? 0
        : tests.map((e) => e.price ?? 0).reduce((a, b) => a + b);
  }

  gettotalwitdiscountamount() {
    return (gettotalamount() -
        (int.parse(discount.text.isEmpty ? "0" : discount.text)));
  }

  gettotalwitdiscountwithrecivedamount() {
    return int.parse(recivedamount.text.isEmpty ? "0" : recivedamount.text);
  }

  getfinalamount() {
    return (gettotalwitdiscountamount() -
        (int.parse(recivedamount.text.isEmpty ? "0" : recivedamount.text)));
  }

  Future<void> fetchTests(int pageKey) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseUrl}/tests?page=$pageKey&limit=$_pageSize${searchcontrller.text.trim().isNotEmpty ? "&search=${searchcontrller.text}" : ""}",
        ),
      );

      final data = jsonDecode(response.body);
      log(data.toString());
      GetAllTestModel getAllTestModel = GetAllTestModel.fromJson(data);
      final List<Test> newItems = getAllTestModel.data?.tests ?? [];

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

  Future<void> fetchGroupTests(int pageKey) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseUrl}/tests/groups?page=$pageKey&limit=$_pageSize${searchcontrller.text.trim().isNotEmpty ? "&search=${searchcontrller.text}" : ""}",
        ),
      );

      final data = jsonDecode(response.body);
      log(data.toString());
      GroupTestModel getAllTestModel = GroupTestModel.fromJson(data);
      final List<Group> newItems = getAllTestModel.data?.groups ?? [];

      final isLastPage =
          pageKey >= (getAllTestModel.data?.pagination?.totalPages ?? 0);

      if (isLastPage) {
        grouptestController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        grouptestController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      log(error.toString());
      grouptestController.error = error;
    }
  }

  CreateCase() async {
    isLoading = true;
    update();
    try {
      final url = Uri.parse("${AppConfig.baseUrl}/cases");

      final body = {
        if (selectedpatient != null) "patientId": selectedpatient?.sId,
        if (selectedpatient == null)
          "patientData": {
            "firstName": nameController.text,
            "lastName": "",
            "age": int.parse(yearsController.text),
            "months": int.parse(monthsController.text),
            "days": int.parse(daysController.text),
            "gender": selectedSex.value,
            "phoneNumbers": [
              "+${phoneNumber.value.countryCode} ${phoneNumber.value.nsn}",
            ],
            "email": emailController.text,
            "address": {
              "line1": address.text,
              //  getFullAddress(
              //   Address.fromJson({
              //     "line1": address.text,
              //     "line2": address2.text,
              //     "city": city.text,
              //     "state": state.text,
              //     "postalCode": pincode.text,
              //     "country": "India",
              //   }),
              // ),
              "line2": "",
              "city": "",
              "state": "",
              "postalCode": "",
              "country": "INDIA",
            },
          },
        "tests": [
          selectedTests.map((e) => {"testId": e.id}).toList(),
          for (int i = 0; i < selectedGroupTests.length; i++)
            (selectedGroupTests[i].tests ?? [])
                .map(
                  (e) => {
                    "testId": e.id,
                    "groupId": (e.groupIds ?? []).isEmpty
                        ? ""
                        : (e.groupIds ?? []).first,
                  },
                )
                .toList(),
        ].expand((e) => e).toList(),
        "referringDoctor": selectedDoctor?.id,
        "center": selectedCenter?.id,
        "totalAmount": gettotalamount(),
        "discountType": "Flat",
        "discountValue": int.parse(
          ((discount.text.isEmpty) ? "0" : discount.text.isEmpty).toString(),
        ),
        "finalAmount": gettotalwitdiscountamount(),
      };

      log(body.toString());
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      var model = jsonDecode(response.body);
      log(response.statusCode.toString());
      log(model.toString());
      if (response.statusCode == 201 && model["code"] == 201) {
        if (recivedamount.text.isEmpty || recivedamount.text == "0") {
          Get.back();
          Get.find<HomeController>().OnRefresh();
        } else {
          await CreateTransaction(model["data"]["case"]["_id"]);
        }
      } else {
        log(model["message"]);
        Get.snackbar(
          "Error",
          model["message"] ?? "Case Creation failed please try again",
          colorText: AppColor.whitecolor,

          backgroundColor: AppColor.redcolor,
        );
        isLoading = false;
        update();
        return null;
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Exception: $e");
      return null;
    } finally {}
  }

  CreateTransaction(caseid) async {
    isLoading = true;
    update();
    try {
      final url = Uri.parse("${AppConfig.baseUrl}/transactions");

      final body = {
        "caseId": caseid,
        "amountGiven": int.parse(
          recivedamount.text.isEmpty ? "0" : recivedamount.text,
        ),
        "mode": selectedMode.value.toLowerCase(),
      };

      print(body.toString());
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      var model = jsonDecode(response.body);

      if (response.statusCode == 201 && model["code"] == 201) {
        Get.back();
        Get.find<HomeController>().OnRefresh();
      } else {
        Get.snackbar(
          "Error",
          model["message"] ?? "Case Creation failed please try again",
          colorText: AppColor.whitecolor,

          backgroundColor: AppColor.redcolor,
        );
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    } finally {
      isLoading = false;
      update();
    }
  }
}
