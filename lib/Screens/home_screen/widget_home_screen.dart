import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labapp/Constants/extensions.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Screens/case_details/case_details_screen.dart';
import 'package:labapp/Screens/case_details/controller_case_details_screen.dart';
import 'package:labapp/Screens/report_details/controller_report_details_screen.dart';
import 'package:labapp/Screens/report_details/report_details_screen.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/utils/app_color.dart';

import '../../models/caseModel.dart';

class HomeScreenWidget {
  Widget tabbarWidget(int tabIndex) {
    final HomeController controller = Get.find<HomeController>();

    PagingController<int, CaseModel> pagingController;
    switch (tabIndex) {
      case 0:
        pagingController = controller.allPagingController;
        break;
      case 1:
        pagingController = controller.newPagingController;
        break;
      // case 2:
      //   pagingController = controller.newPagingController; // temporary
      //   break;
      case 3:
        pagingController = controller.finalPagingController;
        break;
      case 4:
        pagingController = controller.signOffPagingController;
        break;
      default:
        pagingController = controller.allPagingController;
    }

    return RefreshIndicator(
      onRefresh: () async {
        pagingController.refresh();
        return Future.value();
      },
      child: PagedListView<int, CaseModel>(
        pagingController: pagingController,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        builderDelegate: PagedChildBuilderDelegate<CaseModel>(
          noItemsFoundIndicatorBuilder: (context) =>
              const Center(child: Text("No cases found")),
          itemBuilder: (context, item, index) {
            final isOdd = index.isOdd;
            return InkWell(
              onTap: () {
                if (!isOdd) {
                  Get.lazyPut(() => CaseDetailsContoller());
                  Get.to(() => CaseDetailsScreen());
                } else {
                  Get.lazyPut(() => ReportDetailsContoller());
                  Get.to(() => ReportDetailsScreen());
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IntrinsicHeight(
                  child: Row(
                    spacing: 14.w,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColor.secondarycolor,
                                width: 1.w,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 15.h,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 3.0,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextConstant(
                                        title: (item.patient ?? []).isEmpty
                                            ? "N/A"
                                            : "${item.patient?.first.firstName ?? ''} (#${item.patient?.first.patientId ?? ''})",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    TextConstant(
                                      title: "#${item.caseId ?? ''}",
                                      fontSize: 13.0,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextConstant(
                                      title: (item.patient ?? []).isEmpty
                                          ? "N/A"
                                          : item
                                                    .patient
                                                    ?.first
                                                    .phoneNumbers
                                                    ?.first ??
                                                '',
                                      fontSize: 13.0,
                                    ),
                                    const Spacer(),
                                    TextConstant(
                                      title:
                                          "${item.casetests?.length ?? 0} Tests",
                                      fontSize: 13.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 83.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isOdd ? Colors.orange : Colors.green,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: TextConstant(
                          title:
                              "${formatIndianCurrency((item.finalAmount ?? 0))}",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
