import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/textfield_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:labapp/Screens/bookcase_screen/ui_bookcase_screen.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/Screens/home_screen/filter_screen.dart';
import 'package:labapp/Screens/home_screen/widget_home_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logos/logo.png', height: 40.h, width: 40.h),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConstant(title: 'Pathology Lab'),
                TextConstant(
                  title: 'Goel Diagnostic Center',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            height: 40.h,
            width: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
            child: TextConstant(title: 'AK'),
          ),
          widthBox(10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox(15),
            elevatedButton(
              title: '+ Book A New Case',
              onPressed: () {
                Get.lazyPut(() => BookCaseController());
                Get.to(() => BookCaseScreen());
              },
            ),
            heightBox(14),
            TextConstant(
              title: 'Cases',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            heightBox(10),
            Row(
              spacing: 40.w,
              children: [
                Expanded(
                  child: TextFieldConstant(
                    controller: controller.searchController,
                    hintText: 'Search By Patient ID/Name/ No/ Report ID',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Open filter bottom sheet
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const FilterBottomSheet();
                      },
                    );
                  },
                  child: Icon(TablerIcons.adjustments_horizontal, size: 28.sp),
                ),
              ],
            ),
            heightBox(14),
            Obx(() {
              controller.selectedIndex.value;
              return TabBar(
                controller: controller.tabController,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                isScrollable: true,
                dividerColor: Colors.grey.withValues(alpha: 0.5),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) {
                  controller.setTabIndex(index);
                },
                tabs: [
                  Tab(
                    child: TextConstant(
                      title: 'All',
                      textAlign: TextAlign.center,
                      fontWeight: controller.selectedIndex.value == 0
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                  Tab(
                    child: TextConstant(
                      title: 'New',
                      textAlign: TextAlign.center,
                      fontWeight: controller.selectedIndex.value == 1
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                  Tab(
                    child: TextConstant(
                      title: 'In Progress',
                      textAlign: TextAlign.center,
                      fontWeight: controller.selectedIndex.value == 2
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                  Tab(
                    child: TextConstant(
                      title: 'Final',
                      textAlign: TextAlign.center,
                      fontWeight: controller.selectedIndex.value == 3
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                  Tab(
                    child: TextConstant(
                      title: 'Signed Off',
                      textAlign: TextAlign.center,
                      fontWeight: controller.selectedIndex.value == 4
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                ],
              );
            }),
            Obx(() {
              controller.selectedIndex.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      HomeScreenWidget().tabbarWidget(),
                      HomeScreenWidget().tabbarWidget(),
                      HomeScreenWidget().tabbarWidget(),
                      HomeScreenWidget().tabbarWidget(),
                      HomeScreenWidget().tabbarWidget(),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
