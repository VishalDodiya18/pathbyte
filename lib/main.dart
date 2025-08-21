import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:labapp/Screens/home_screen/controller_home_screen.dart';
import 'package:labapp/Screens/home_screen/ui_home_screen.dart';
import 'package:labapp/utils/app_color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(428, 926),
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Pathbyte',

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: "Inter",
              appBarTheme: AppBarTheme(
                shadowColor: AppColor.transparentcolor,
                backgroundColor: AppColor.transparentcolor,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppColor.primary),
                centerTitle: T,
                titleTextStyle: TextStyle(
                  color: AppColor.primary,

                  fontSize: 21.h,
                  fontWeight: FontWeight.w600,
                ),
                surfaceTintColor: AppColor.transparentcolor,
              ),
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
