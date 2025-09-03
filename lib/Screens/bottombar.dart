import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        currentIndex: currentindex,
        backgroundColor: AppColor.whitecolor,
        elevation: 15,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
