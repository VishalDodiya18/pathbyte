import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController  with GetSingleTickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();

  late TabController tabController;
  RxInt selectedIndex = 0.obs;

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