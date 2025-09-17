import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pathbyte/Constants/extensions.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/Screens/home_screen/controller_home_screen.dart';
import 'package:pathbyte/Screens/patients/patient_controller.dart';
import 'package:pathbyte/Screens/patients/patient_details_controller.dart';
import 'package:pathbyte/helper/helpers.dart';
import 'package:pathbyte/models/caseModel.dart';
import 'package:pathbyte/models/case_details_model.dart' hide Doctor, Patient;
import 'package:pathbyte/models/doctor_model.dart' hide Address;
import 'package:pathbyte/models/group_test_model.dart';
import 'package:pathbyte/models/lab_center_model.dart';
import 'package:pathbyte/models/test_model.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';
import 'package:phone_form_field/phone_form_field.dart';

class EditBookCaseController extends GetxController {
  CaseDetails caseDetails;

  EditBookCaseController({required this.caseDetails});
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

  List<String> mrmissList = [
    'Mr.', 'Mrs.', 'Ms.',

    //  'Dr.'
  ];
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

    if (caseDetails.caseId != null) {
      selectedCenter = caseDetails.labcenter;
      selectedDoctor = caseDetails.doctor;
      dateController.text = caseDetails.createdAt!.toIso8601String();
      phoneNumber = PhoneController(
        initialValue: PhoneNumber(
          isoCode: IsoCode.IN,
          nsn: (caseDetails.patient?.phoneNumbers ?? []).first
              .replaceAll("+91", "")
              .trim(),
        ),
      );
      selectedTitle.value = caseDetails.patient?.title ?? "Mr.";
      nameController.text = caseDetails.patient?.firstName ?? "";
      emailController.text = caseDetails.patient?.email ?? "";
      selectedSex.value = caseDetails.patient?.gender ?? "Male";
      yearsController.text = (caseDetails.patient?.age ?? 20).toString();
      monthsController.text = (caseDetails.patient?.months ?? 0).toString();
      monthsController.text = (caseDetails.patient?.days ?? 0).toString();
      address.text = caseDetails.patient?.address?.line1 ?? "";
      selectedTests = (caseDetails.casetests ?? [])
          .where((element) => element.groupId == null)
          .map((e) => e.test!)
          .toList();

      selectedGroupTests = (caseDetails.casetests ?? [])
          .where((e) => e.groupId != null && e.group != null)
          .map((e) => e.group!)
          .fold<Map<String, Group>>({}, (map, group) {
            map[group.groupId!] = group;
            return map;
          })
          .values
          .toList()
          .cast<Group>();
      selectedpatient = caseDetails.patient;

      selectedGroupTests.forEach((element) {
        element.tests = (caseDetails.casetests ?? [])
            .where((e) => e.groupId == element.id)
            .map((e) => e.test!)
            .toList();
      });
    }
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
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );

      final data = jsonDecode(response.body);
        if (response.statusCode == 500) {
        Logout(message: data["message"] ?? "Your Session is expired");
        return;
      }
      //log(data.toString());
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
      //log(error.toString());
      pagingController.error = error;
    }
  }

  Future<void> fetchGroupTests(int pageKey) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseUrl}/tests/groups?page=$pageKey&limit=$_pageSize${searchcontrller.text.trim().isNotEmpty ? "&search=${searchcontrller.text}" : ""}",
        ),
        headers: {"Authorization": "Bearer ${AppConfig.Token}"},
      );

      final data = jsonDecode(response.body);
      //log(data.toString());
      if (response.statusCode == 500) {
        Logout(message: data["message"] ?? "Your Session is expired");
        return;
      }
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
      //log(error.toString());
      grouptestController.error = error;
    }
  }

  CreateCase() async {
    isLoading = true;
    update();
    try {
      final url = Uri.parse("${AppConfig.baseUrl}/cases/${caseDetails.id}");

      final body = {
        if (selectedpatient != null) "patientId": selectedpatient?.sId,
        // if (selectedpatient == null)
        "patientData": {
          "firstName": nameController.text.trim(),
          "lastName": "",
          "title": selectedTitle.value,
          "age": int.parse(yearsController.text.trim()),
          "months": int.parse(monthsController.text.trim()),
          "days": int.parse(daysController.text.trim()),
          "dob": getDobFromAge(
            int.parse(yearsController.text.trim()),
            int.parse(monthsController.text.trim()),
            int.parse(daysController.text.trim()),
            format: "yyyy-MM-dd",
          ),
          "gender": selectedSex.value,
          "phoneNumbers": [
            "+${phoneNumber.value.countryCode} ${phoneNumber.value.nsn}",
          ],
          if (emailController.text.isNotEmpty) "email": emailController.text,
          if (address.text.trim().isNotEmpty)
            "address": {
              "line1": address.text.trim(),
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
              "country": "",
            },
        },
        "tests": [
          selectedTests.map((e) => {"testId": e.id}).toList(),
          for (int i = 0; i < selectedGroupTests.length; i++)
            (selectedGroupTests[i].tests ?? [])
                .map(
                  (e) => {"testId": e.id, "groupId": selectedGroupTests[i].id},
                )
                .toList(),
        ].expand((e) => e).toList(),
        "referringDoctor": selectedDoctor?.id,
        "center": selectedCenter?.id,
        "totalAmount": gettotalamount(),
        "discountType": "Flat",
        "discountValue": int.parse(
          ((discount.text.trim().isEmpty) ? "0" : discount.text.trim())
              .toString(),
        ),
        "finalAmount": gettotalwitdiscountamount(),
      };
      //log("${AppConfig.baseUrl}/cases/${caseDetails.id}");
      //log(body.toString());
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConfig.Token}",
        },
        body: jsonEncode(body),
      );

      var model = jsonDecode(response.body);
      //log(response.statusCode.toString());
      //log(model.toString());
      if (response.statusCode == 500) {
        Logout(message: model["message"] ?? "Your Session is expired");
        return;
      }
      if (response.statusCode == 200 && model["code"] == 200) {
        Get.back();
        Get.find<CaseDetailsContoller>().fetchCaseById();
        Get.find<HomeController>().OnRefresh();
        Get.find<PatientController>().patientPagingController.refresh();
        if (Get.isRegistered<PatientDetailsController>()) {
          Get.find<PatientDetailsController>().fetchpatient();
          Get.find<PatientDetailsController>().allPagingController.refresh();
        }
      } else {
        //log(model["message"]);
        Get.snackbar(
          "Error",
          model["message"] ?? "Case updation failed please try again",
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

  // CreateTransaction(caseid) async {
  //   isLoading = true;
  //   update();
  //   try {
  //     final url = Uri.parse("${AppConfig.baseUrl}/transactions");

  //     final body = {
  //       "caseId": caseid,
  //       "amountGiven": int.parse(
  //         recivedamount.text.isEmpty ? "0" : recivedamount.text,
  //       ),
  //       "mode": selectedMode.value.toLowerCase(),
  //     };

  //     print(body.toString());
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json","Authorization":"Bearer ${AppConfig.Token}"},
  //       body: jsonEncode(body),
  //     );

  //     var model = jsonDecode(response.body);

  //     if (response.statusCode == 201 && model["code"] == 201) {
  //       Get.back();
  //       Get.find<HomeController>().OnRefresh();
  //     } else {
  //       Get.snackbar(
  //         "Error",
  //         model["message"] ?? "Case Creation failed please try again",
  //         colorText: AppColor.whitecolor,

  //         backgroundColor: AppColor.redcolor,
  //       );
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //     return null;
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
