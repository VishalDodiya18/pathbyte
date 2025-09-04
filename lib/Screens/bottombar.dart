import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:labapp/Constants/elevated_button_constant.dart';
import 'package:labapp/Constants/text_constant.dart';
import 'package:labapp/Constants/widget_constant.dart';
import 'package:labapp/Screens/bookcase_screen/controller_bookcase_screen.dart';
import 'package:labapp/Screens/bookcase_screen/ui_bookcase_screen.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/Screens/home_screen/ui_home_screen.dart';
import 'package:labapp/Screens/patients/patient_controller.dart';
import 'package:labapp/Screens/patients/patients.dart';
import 'package:labapp/utils/app_color.dart';

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
    super.initState();
  }

  int currentindex = 0;

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
        bottom: PreferredSize(
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
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
