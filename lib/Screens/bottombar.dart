import 'dart:ui';

import 'package:pathbyte/Screens/splashscreen/Login.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/instance_manager.dart';
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Constants/widget_constant.dart';
import 'package:pathbyte/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:pathbyte/Screens/bookcase_screen/ui_bookcase_screen.dart';
import 'package:pathbyte/Screens/home_screen/controller_home_screen.dart';
import 'package:pathbyte/Screens/home_screen/ui_home_screen.dart';
import 'package:pathbyte/Screens/patients/patient_controller.dart';
import 'package:pathbyte/Screens/patients/patients.dart';
import 'package:pathbyte/helper/helpers.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  @override
  void initState() {
    Get.put(HomeController());
    Get.put(PatientController());
    getdata();
    super.initState();
  }

  int currentindex = 0;
  getdata() async {
    AppConfig.Role = await GetString("role");
    AppConfig.UserId = await GetString("userid");
    AppConfig.FullName = await GetString("name");
    AppConfig.labname = await GetString("labname");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: F,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: F,
          title: Row(
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppImage.app_icon, height: 40.h, width: 50.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextConstant(title: AppConfig.labname ?? ""),
                  TextConstant(
                    title: AppConfig.FullName ?? "",
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
              decoration: const BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: TextConstant(
                title: AppConfig.FullName.getInitials.toUpperCase(),
                fontWeight: FontWeight.bold,
              ),
            ),
            widthBox(10),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: StatefulBuilder(
                        builder: (context, set) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Center(
                              child: IntrinsicHeight(
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Are you sure you want\nto log out?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 30.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  Logout();
                                                });
                                                set(() {});
                                              },
                                              child: Container(
                                                height: 50.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.red,
                                                ),
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15.0),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Container(
                                                height: 50.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: AppColor.blackcolor,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor.blackcolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ).whenComplete(() {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.logout, color: AppColor.redcolor),
            ),
          ],
          bottom: AppConfig.Role.toUpperCase() != "LABTECHNICIAN"
              ? PreferredSize(
                  preferredSize: Size(width, 55.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        heightBox(15),
                        elevatedButton(
                          title: '+ Book A New Case',
                          onPressed: () {
                            Get.lazyPut(() => BookCaseController());
                            Get.to(() => BookCaseScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        ),

        bottomNavigationBar: AppConfig.Role.toUpperCase() == "LABTECHNICIAN"
            ? const SizedBox()
            : BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    currentindex = value;
                  });
                },
                currentIndex: currentindex,
                backgroundColor: AppColor.whitecolor,
                elevation: 15,
                selectedItemColor: AppColor.primary,

                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.medical_information),
                    label: "Cases",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2),
                    label: "Patients",
                  ),
                ],
              ),

        body: currentindex == 0 ? HomeScreen() : const Patientes(),
      ),
    );
  }
}
