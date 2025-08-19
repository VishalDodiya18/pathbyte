import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labapp/Screens/home_screen/ui_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Lap App',
          debugShowCheckedModeBanner: false,theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          home: HomeScreen(),
        );
      },
    );
  }
}