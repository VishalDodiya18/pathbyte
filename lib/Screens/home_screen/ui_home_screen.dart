import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Constants/textfield_constant.dart';
import 'package:pathbyte/Constants/widget_constant.dart';
import 'package:pathbyte/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:pathbyte/Screens/bookcase_screen/ui_bookcase_screen.dart';
import 'package:pathbyte/Screens/home_screen/controller_home_screen.dart';
import 'package:pathbyte/Screens/home_screen/filter_screen.dart';
import 'package:pathbyte/Screens/home_screen/widget_home_screen.dart';
import 'package:pathbyte/utils/app_config.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox(14),
            TextConstant(
              title: AppConfig.Role.toUpperCase() == "LABTECHNICIAN"
                  ? "Reports"
                  : 'Cases',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            heightBox(10),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Row(
                  spacing: 40.w,
                  children: [
                    Expanded(
                      child: TextFieldConstant(
                        controller: controller.searchController,
                        hintText: 'Search By Patient ID/Name/ No/ Report ID',
                        suffixIcon:
                            controller.searchController.text.trim().isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  controller.searchController.clear();
                                  controller.update();
                                  controller.OnRefresh();
                                },
                                child: Icon(Icons.clear_rounded, size: 25.h),
                              )
                            : null,
                        onChanged: (p0) {
                          controller.update();

                          EasyDebounce.debounce(
                            'case-search-debouncer',
                            Duration(milliseconds: 500),
                            () => controller.OnRefresh(),
                          );
                        },
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
                      child: Icon(
                        TablerIcons.adjustments_horizontal,
                        size: 28.sp,
                      ),
                    ),
                  ],
                );
              },
            ),
            heightBox(14),

            GetBuilder<HomeController>(
              builder: (controller) {
                return Obx(
                  () => TabBar(
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
                          title:
                              'All${controller.selectedIndex.value != 0
                                  ? ""
                                  : controller.allCaselistmodel != null
                                  ? " ( ${controller.allCaselistmodel?.data?.pagination?.total ?? 0} )"
                                  : " ( 0 )"}',
                          textAlign: TextAlign.center,
                          fontWeight: controller.selectedIndex.value == 0
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                      Tab(
                        child: TextConstant(
                          title:
                              "New${controller.selectedIndex.value != 1
                                  ? ""
                                  : controller.newCaselistmodel != null
                                  ? " ( ${controller.newCaselistmodel?.data?.pagination?.total ?? 0} )"
                                  : " ( 0 )"}",
                          textAlign: TextAlign.center,
                          fontWeight: controller.selectedIndex.value == 1
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                      Tab(
                        child: TextConstant(
                          title:
                              'In Progress${controller.selectedIndex.value != 2
                                  ? ""
                                  : controller.inprogressCaselistmodel != null
                                  ? " ( ${controller.inprogressCaselistmodel?.data?.pagination?.total ?? 0} )"
                                  : " ( 0 )"}',
                          textAlign: TextAlign.center,
                          fontWeight: controller.selectedIndex.value == 2
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),

                      Tab(
                        child: TextConstant(
                          title:
                              'Final${controller.selectedIndex.value != 3
                                  ? ""
                                  : controller.finalCaselistmodel != null
                                  ? " ( ${controller.finalCaselistmodel?.data?.pagination?.total ?? 0} )"
                                  : " ( 0 )"}',
                          textAlign: TextAlign.center,
                          fontWeight: controller.selectedIndex.value == 3
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                      Tab(
                        child: TextConstant(
                          title:
                              'Signed Off${controller.selectedIndex.value != 4
                                  ? ""
                                  : controller.signoffCaselistmodel != null
                                  ? " ( ${controller.signoffCaselistmodel?.data?.pagination?.total ?? 0} )"
                                  : " ( 0 )"}',
                          textAlign: TextAlign.center,
                          fontWeight: controller.selectedIndex.value == 4
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Obx(() {
              controller.selectedIndex.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.tabController,
                    children: [
                      HomeScreenWidget().tabbarWidget(0),
                      HomeScreenWidget().tabbarWidget(1),
                      HomeScreenWidget().tabbarWidget(2),
                      HomeScreenWidget().tabbarWidget(3),
                      HomeScreenWidget().tabbarWidget(4),
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
