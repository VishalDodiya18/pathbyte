import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';

class BookCaseController extends GetxController {
  TextEditingController caseIdController = TextEditingController(
    text: '#123345',
  );
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final TextEditingController yearsController = TextEditingController(
    text: '24',
  );
  final TextEditingController monthsController = TextEditingController(
    text: '0',
  );
  final TextEditingController daysController = TextEditingController(text: '0');

  var phoneNumber = PhoneNumber.parse('+91').obs;

  void updatePhone(PhoneNumber number) {
    phoneNumber.value = number;
    print("Updated phone number: $number");
  }

  List<String> referreingDocList = [
    'Dr. Parul Singhal',
    'Dr. Parul Patel',
    'Dr. Mayank Patel',
    'Dr. Sanjay Dutt',
    'Dr. Om Shah',
  ];
  RxString selectedReferringDoc = 'Dr. Parul Singhal'.obs;
  List<String> centerList = ['Main Lab', 'Office Lab', 'Laboratory Lab'];
  RxString selectedCenter = 'Main Lab'.obs;
  List<String> mrmissList = ['Mr.', 'Miss.'];
  RxString selectedTitle = 'Mr.'.obs;
  List<String> sexList = ['Male', 'Female'];
  RxString selectedSex = 'Male'.obs;
  List<String> modeList = ['Cash', 'UPI', 'Bank'];
  RxString selectedMode = 'Cash'.obs;
}
