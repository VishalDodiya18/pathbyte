import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(_tabListener);
  }

  void _tabListener() {
    selectedIndex.value = tabController.index;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void setTabIndex(int index) {
    selectedIndex.value = index;
    tabController.index = index;
  }
}
