import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/extensions.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Constants/widget_constant.dart';
import 'package:pathbyte/Screens/case_details/main_details_screen.dart';
import 'package:pathbyte/Screens/case_details/controller_case_details_screen.dart';
import 'package:pathbyte/Screens/patients/patient_details_controller.dart';
import 'package:pathbyte/Screens/home_screen/controller_home_screen.dart';
import 'package:pathbyte/models/caseModel.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';

class HomeScreenWidget {
  Widget tabbarWidget(int tabIndex) {
    final HomeController controller = Get.find<HomeController>();

    PatientDetailsController? Pcontroller;
    if (tabIndex == 4) Pcontroller = Get.find<PatientDetailsController>();

    PagingController<int, Cases> pagingController;
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
      case 2:
        pagingController = controller.finalPagingController;
        break;
      case 3:
        pagingController = controller.signOffPagingController;
        break;
      case 4:
        pagingController = Pcontroller!.allPagingController;
        break;
      default:
        pagingController = controller.allPagingController;
    }

    return RefreshIndicator(
      onRefresh: () async {
        pagingController.refresh();
        return Future.value();
      },
      child: PagedListView<int, Cases>(
        pagingController: pagingController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        builderDelegate: PagedChildBuilderDelegate<Cases>(
          noItemsFoundIndicatorBuilder: (context) =>
              Center(child: Image.asset(AppImage.nodatafound)),
          itemBuilder: (context, item, index) {
            return Padding(
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
                                      title: (item.patient == null)
                                          ? "N/A"
                                          : "${item.patient?.firstName ?? ''}",
                                      // : "${item.patient?.firstName ?? ''} (#${item.patient?.patientId ?? ''})",
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
                                    title: (item.patient == null)
                                        ? "N/A"
                                        : item.patient?.phoneNumbers?.first ??
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
                              if (T
                              // AppConfig.Role.toUpperCase() ==
                              //     "LABTECHNICIAN"
                              ) ...[
                                SizedBox(height: 5.0),
                                Row(
                                  spacing: 10.0,
                                  children: [
                                    Expanded(
                                      child: elevatedButton(
                                        height: 30.0,
                                        title: "Enter Results",
                                        onPressed: () {
                                          Get.lazyPut(
                                            () => CaseDetailsContoller(
                                              caseId: item.sId,
                                            ),
                                          );
                                          Get.to(
                                            () => MainDetailsScreen(
                                              isreport: T,
                                              isview: F,
                                              // AppConfig.Role.toUpperCase() ==
                                              //     "LABTECHNICIAN"
                                              // ? T
                                              // : F,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: elevatedButton(
                                        height: 30.0,
                                        title: "View Report",
                                        onPressed: () {
                                          Get.lazyPut(
                                            () => CaseDetailsContoller(
                                              caseId: item.sId,
                                            ),
                                          );
                                          Get.to(
                                            () => MainDetailsScreen(
                                              isreport: T,
                                              // AppConfig.Role.toUpperCase() ==
                                              //     "LABTECHNICIAN"
                                              // ? T
                                              // : F,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                SizedBox(height: 5.0),

                                elevatedButton(
                                  height: 30.0,
                                  title: "View Case",
                                  onPressed: () {
                                    Get.lazyPut(
                                      () => CaseDetailsContoller(
                                        caseId: item.sId,
                                      ),
                                    );
                                    Get.to(
                                      () => MainDetailsScreen(
                                        isreport: F,
                                        // AppConfig.Role.toUpperCase() ==
                                        //     "LABTECHNICIAN"
                                        // ? T
                                        // : F,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 83.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (item.transactions ?? []).isEmpty
                            ? Colors.red
                            : (item.transactions ?? [])
                                      .map((e) => e.amountGiven)
                                      .reduce(
                                        (a, b) =>
                                            num.parse((a ?? 0).toString()) +
                                            num.parse((b ?? 0).toString()),
                                      ) ==
                                  item.finalAmount
                            ? Colors.green
                            : Colors.orange,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextConstant(
                            title: formatIndianCurrency(
                              (item.finalAmount ?? 0),
                            ),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          heightBox(5),
                          TextConstant(
                            title: (item.transactions ?? []).isEmpty
                                ? "Unpaid"
                                : (item.transactions ?? [])
                                          .map((e) => e.amountGiven)
                                          .reduce(
                                            (a, b) =>
                                                num.parse((a ?? 0).toString()) +
                                                num.parse((b ?? 0).toString()),
                                          ) ==
                                      item.finalAmount
                                ? "Paid"
                                : "Unpaid",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
