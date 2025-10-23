import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pathbyte/Screens/splashscreen/SplashScreen.dart';
import 'package:pathbyte/utils/app_color.dart';

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
              primaryColor: AppColor.primary,
              fontFamily: "Inter",
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: AppColor.whitecolor,
              ),
              appBarTheme: AppBarTheme(
                shadowColor: AppColor.transparentcolor,
                backgroundColor: AppColor.transparentcolor,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppColor.primary),
                centerTitle: T,
                titleTextStyle: TextStyle(
                  color: AppColor.primary,
                  fontSize: 19.h,
                  fontWeight: FontWeight.w600,
                ),
                surfaceTintColor: AppColor.transparentcolor,
              ),
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
