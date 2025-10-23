// ignore_for_file: non_constant_identifier_names, prefer_final_fields, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:pathbyte/Constants/elevated_button_constant.dart';
import 'package:pathbyte/Constants/text_constant.dart';
import 'package:pathbyte/Constants/textfield_constant.dart';
import 'package:pathbyte/Screens/bottombar.dart';
import 'package:pathbyte/Screens/home_screen/ui_home_screen.dart';
import 'package:pathbyte/helper/helpers.dart';
import 'package:pathbyte/utils/app_color.dart';
import 'package:pathbyte/utils/app_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController EmailAddress = TextEditingController();
  // TextEditingController Password = TextEditingController();
  TextEditingController EmailAddress = TextEditingController(
    text: kDebugMode ? "admin1@pathbyte.com" : "",
  );
  TextEditingController Password = TextEditingController(
    text: kDebugMode ? "Admin@123" : "",
  );
  GlobalKey<FormState> _Key = GlobalKey<FormState>();
  bool pass = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: F,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(title: "Sign in", leading: "null"),
          body: Form(
            key: _Key,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: TextConstant(
                      title: "Pathbyte",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  AppImage.app_icon,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextFieldConstant(
                  controller: EmailAddress,
                  hintText: "Email Address",
                  validator: (v) => v!.isEmpty
                      ? "Please Enter Email Address"
                      : RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(v)
                          ? null
                          : "Please Enter Valid Email Address",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.018),

                TextFieldConstant(
                  controller: Password,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        pass = !pass;
                      });
                    },
                    child: Icon(
                      pass ? Icons.visibility : Icons.visibility_off,
                      color: AppColor.blackcolor,
                    ),
                  ),
                  hintText: "Password",
                  validator: (v) => v!.isEmpty
                      ? "Please Enter Password"
                      : v.length > 6
                          ? null
                          : "Password Must be more than 6 characters",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                // RichText(
                //     text: TextSpan(
                //         text: "Don't have account",
                //         style: const TextStyle(
                //             fontFamily: "Rubik", color: AppColor.blackcolor),
                //         children: [
                //       TextSpan(
                //           text: "   Sign Up   ",
                //           recognizer: TapGestureRecognizer()
                //             ..onTap = () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => const RegisterPage()));
                //             },
                //           style: const TextStyle(
                //               fontFamily: "Rubik",
                //               fontSize: 15.0,
                //               color: AppColor.blackcolor,
                //               fontWeight: FontWeight.bold))
                //     ])),
                // const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: elevatedButton(
                    isLoading: isLoading,
                    title: "Sign In",
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_Key.currentState!.validate()) {
                        Login();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Login() async {
    try {
      setState(() {
        isLoading = true;
      });
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse('${AppConfig.baseUrl}/auth/login'),
      );
      request.body = json.encode({
        "email": EmailAddress.text,
        "password": Password.text,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var model = jsonDecode(await response.stream.bytesToString());
      log(model.toString());
      if (model["code"] == 200) {
        SetString("token", model["data"]["accessToken"]);
        SetString("userid", model["data"]["user"]["_id"]);
        SetString("role", model["data"]["user"]["roles"][0]["name"]);
        SetString("name", model["data"]["user"]["fullName"]);
        SetString("labname", model["data"]["user"]["labs"][0]["name"]);
        setState(() {
          isLoading = false;
          AppConfig.Token = model["data"]["accessToken"];

          Get.to(Bottombar());
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(model["message"])));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
