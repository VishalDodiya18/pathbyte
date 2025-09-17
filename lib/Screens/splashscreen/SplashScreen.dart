import 'dart:developer';

import 'package:pathbyte/Screens/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathbyte/Screens/home_screen/ui_home_screen.dart';
import 'package:pathbyte/Screens/splashscreen/Login.dart';
import 'package:pathbyte/helper/helpers.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GetString("token"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != "null") AppConfig.Token = snapshot.data;
            return snapshot.data == "null" ? const LoginPage() : Bottombar();
          }
          return Center(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(AppImage.app_icon, height: context.height * 0.1),
                const Spacer(),
                CircularProgressIndicator(color: AppColor.primary),
                const SizedBox(height: 50.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
