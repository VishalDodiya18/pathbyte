// To parse this JSON data, do
//
//     final reportDetailsModel = reportDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/widgets.dart';

ReportDetailsModel reportDetailsModelFromJson(String str) =>
    ReportDetailsModel.fromJson(json.decode(str));

String reportDetailsModelToJson(ReportDetailsModel data) =>
    json.encode(data.toJson());

class ReportDetailsModel {
  int? code;
  String? message;
  Data? data;

  ReportDetailsModel({this.code, this.message, this.data});

  factory ReportDetailsModel.fromJson(Map<String, dynamic> json) =>
      ReportDetailsModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Reportdetail? reportdetail;

  Data({this.reportdetail});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reportdetail: json["reportdetail"] == null
        ? null
        : Reportdetail.fromJson(json["reportdetail"]),
  );

  Map<String, dynamic> toJson() => {"reportdetail": reportdetail?.toJson()};
}

class Reportdetail {
  CaseDetails? caseDetails;
  List<Category>? categories;

  Reportdetail({this.caseDetails, this.categories});

  factory Reportdetail.fromJson(Map<String, dynamic> json) => Reportdetail(
    caseDetails: json["caseDetails"] == null
        ? null
        : CaseDetails.fromJson(json["caseDetails"]),
    categories: json["categories"] == null
        ? []
        : List<Category>.from(
            json["categories"]!.map((x) => Category.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "caseDetails": caseDetails?.toJson(),
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class CaseDetails {
  CaseIdEnum? id;
  String? caseId;
  String? patientId;
  String? status;
  String? referringDoctor;
  String? center;
  int? totalAmount;
  String? discountType;
  int? discountValue;
  int? finalAmount;
  String? amountStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Patient? patient;
  Doctor? doctor;

  CaseDetails({
    this.id,
    this.caseId,
    this.patientId,
    this.status,
    this.referringDoctor,
    this.center,
    this.totalAmount,
    this.discountType,
    this.discountValue,
    this.finalAmount,
    this.amountStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.patient,
    this.doctor,
  });

  factory CaseDetails.fromJson(Map<String, dynamic> json) => CaseDetails(
    id: caseIdEnumValues.map[json["_id"]]!,
    caseId: json["caseId"],
    patientId: json["patientId"],
    status: json["status"],
    referringDoctor: json["referringDoctor"],
    center: json["center"],
    totalAmount: json["totalAmount"],
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    finalAmount: json["finalAmount"],
    amountStatus: json["amountStatus"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
    doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": caseIdEnumValues.reverse[id],
    "caseId": caseId,
    "patientId": patientId,
    "status": status,
    "referringDoctor": referringDoctor,
    "center": center,
    "totalAmount": totalAmount,
    "discountType": discountType,
    "discountValue": discountValue,
    "finalAmount": finalAmount,
    "amountStatus": amountStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "patient": patient?.toJson(),
    "doctor": doctor?.toJson(),
  };
}

class Doctor {
  String? id;
  String? doctorId;
  String? firstName;
  String? lastName;
  String? description;
  int? age;
  String? gender;
  String? notificationStatus;
  String? hospitalName;
  List<String>? phoneNumbers;
  String? email;
  Address? address;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Doctor({
    this.id,
    this.doctorId,
    this.firstName,
    this.lastName,
    this.description,
    this.age,
    this.gender,
    this.notificationStatus,
    this.hospitalName,
    this.phoneNumbers,
    this.email,
    this.address,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["_id"],
    doctorId: json["doctorId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    description: json["description"],
    age: json["age"],
    gender: json["gender"],
    notificationStatus: json["notificationStatus"],
    hospitalName: json["hospitalName"],
    phoneNumbers: json["phoneNumbers"] == null
        ? []
        : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
    email: json["email"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    deleted: json["deleted"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "doctorId": doctorId,
    "firstName": firstName,
    "lastName": lastName,
    "description": description,
    "age": age,
    "gender": gender,
    "notificationStatus": notificationStatus,
    "hospitalName": hospitalName,
    "phoneNumbers": phoneNumbers == null
        ? []
        : List<dynamic>.from(phoneNumbers!.map((x) => x)),
    "email": email,
    "address": address?.toJson(),
    "deleted": deleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Address {
  String? line1;
  String? line2;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  Address({
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    line1: json["line1"],
    line2: json["line2"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postalCode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "line1": line1,
    "line2": line2,
    "city": city,
    "state": state,
    "postalCode": postalCode,
    "country": country,
  };
}

enum CaseIdEnum { THE_68_BBECA7_DC371_F762_CD407_AC }

final caseIdEnumValues = EnumValues({
  "68bbeca7dc371f762cd407ac": CaseIdEnum.THE_68_BBECA7_DC371_F762_CD407_AC,
});

class Patient {
  String? id;
  String? patientId;
  String? firstName;
  String? lastName;
  int? age;
  int? days;
  int? months;
  String? gender;
  List<String>? phoneNumbers;
  String? email;
  Address? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? dob;
  String? title;

  Patient({
    this.id,
    this.patientId,
    this.firstName,
    this.lastName,
    this.age,
    this.days,
    this.months,
    this.gender,
    this.phoneNumbers,
    this.email,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.dob,
    this.title,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["_id"],
    patientId: json["patientId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    age: json["age"],
    days: json["days"],
    months: json["months"],
    gender: json["gender"],
    phoneNumbers: json["phoneNumbers"] == null
        ? []
        : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
    email: json["email"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patientId": patientId,
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
    "days": days,
    "months": months,
    "gender": gender,
    "phoneNumbers": phoneNumbers == null
        ? []
        : List<dynamic>.from(phoneNumbers!.map((x) => x)),
    "email": email,
    "address": address?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "dob": dob?.toIso8601String(),
    "title": title,
  };
}

class Category {
  CategoryIdEnum? id;
  String? name;
  List<GroupedTest>? groupedTests;
  List<Test>? ungroupedTests;

  Category({this.id, this.name, this.groupedTests, this.ungroupedTests});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: categoryIdEnumValues.map[json["_id"]]!,
    name: json["name"],
    groupedTests: json["groupedTests"] == null
        ? []
        : List<GroupedTest>.from(
            json["groupedTests"]!.map((x) => GroupedTest.fromJson(x)),
          ),
    ungroupedTests: json["ungroupedTests"] == null
        ? []
        : List<Test>.from(json["ungroupedTests"]!.map((x) => Test.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": categoryIdEnumValues.reverse[id],
    "name": name,
    "groupedTests": groupedTests == null
        ? []
        : List<dynamic>.from(groupedTests!.map((x) => x.toJson())),
    "ungroupedTests": ungroupedTests == null
        ? []
        : List<dynamic>.from(ungroupedTests!.map((x) => x.toJson())),
  };
}

class GroupedTest {
  String? id;
  String? name;
  List<Test>? caseTests;

  GroupedTest({this.id, this.name, this.caseTests});

  factory GroupedTest.fromJson(Map<String, dynamic> json) => GroupedTest(
    id: json["_id"],
    name: json["name"],
    caseTests: json["caseTests"] == null
        ? []
        : List<Test>.from(json["caseTests"]!.map((x) => Test.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "caseTests": caseTests == null
        ? []
        : List<dynamic>.from(caseTests!.map((x) => x.toJson())),
  };
}

class Test {
  String? id;
  CaseIdEnum? caseId;
  String? testId;
  CategoryIdEnum? categoryId;
  String? groupId;
  String? unit;
  int? price;
  String? footNote;
  List<Characteristic>? characteristics;
  DateTime? createdAt;
  DateTime? updatedAt;
  TestClass? test;
  UngroupedTestAppliedReferenceRange? appliedReferenceRange;
  TextEditingController value;

  Test({
    this.id,
    this.caseId,
    this.testId,
    this.categoryId,
    this.groupId,
    this.unit,
    this.price,
    this.footNote,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
    this.test,
    this.appliedReferenceRange,
    TextEditingController? value,
  }) : value = value ?? TextEditingController();

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["_id"],
    caseId: caseIdEnumValues.map[json["caseId"]]!,
    testId: json["testId"],
    categoryId: categoryIdEnumValues.map[json["categoryId"]]!,
    groupId: json["groupId"],
    unit: json["unit"],
    price: json["price"],
    footNote: json["footNote"],
    characteristics: json["characteristics"] == null
        ? []
        : List<Characteristic>.from(
            json["characteristics"]!.map((x) => Characteristic.fromJson(x)),
          ),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    test: json["test"] == null ? null : TestClass.fromJson(json["test"]),
    appliedReferenceRange: json["appliedReferenceRange"] == null
        ? null
        : UngroupedTestAppliedReferenceRange.fromJson(
            json["appliedReferenceRange"],
          ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "caseId": caseIdEnumValues.reverse[caseId],
    "testId": testId,
    "categoryId": categoryIdEnumValues.reverse[categoryId],
    "groupId": groupId,
    "unit": unit,
    "price": price,
    "footNote": footNote,
    "characteristics": characteristics == null
        ? []
        : List<dynamic>.from(characteristics!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "test": test?.toJson(),
    "appliedReferenceRange": appliedReferenceRange?.toJson(),
  };
}

class UngroupedTestAppliedReferenceRange {
  String? appliesTo;
  String? stringValue;
  String? highValue;
  String? lowValue;

  UngroupedTestAppliedReferenceRange({
    this.appliesTo,
    this.stringValue,
    this.highValue,
    this.lowValue,
  });

  factory UngroupedTestAppliedReferenceRange.fromJson(
    Map<String, dynamic> json,
  ) => UngroupedTestAppliedReferenceRange(
    appliesTo: json["appliesTo"],
    stringValue: json["stringValue"],
    highValue: json["highValue"],
    lowValue: json["lowValue"],
  );

  Map<String, dynamic> toJson() => {
    "appliesTo": appliesTo,
    "stringValue": stringValue,
  };
}

enum CategoryIdEnum {
  THE_68_AC916_E84_AB3_B3456_BA253_F,
  THE_68_B7_F0_C2_BB000_F96_DDD96920,
  THE_68_BAE58_E27_D97_A3_AB2_CAE689,
  THE_68_BAE6_CE27_D97_A3_AB2_CAE6_B3,
}

final categoryIdEnumValues = EnumValues({
  "68ac916e84ab3b3456ba253f": CategoryIdEnum.THE_68_AC916_E84_AB3_B3456_BA253_F,
  "68b7f0c2bb000f96ddd96920": CategoryIdEnum.THE_68_B7_F0_C2_BB000_F96_DDD96920,
  "68bae58e27d97a3ab2cae689": CategoryIdEnum.THE_68_BAE58_E27_D97_A3_AB2_CAE689,
  "68bae6ce27d97a3ab2cae6b3":
      CategoryIdEnum.THE_68_BAE6_CE27_D97_A3_AB2_CAE6_B3,
});

class Characteristic {
  String? name;
  String? unit;
  CharacteristicAppliedReferenceRange? appliedReferenceRange;

  Characteristic({this.name, this.unit, this.appliedReferenceRange});

  factory Characteristic.fromJson(Map<String, dynamic> json) => Characteristic(
    name: json["name"],
    unit: json["unit"],
    appliedReferenceRange: json["appliedReferenceRange"] == null
        ? null
        : CharacteristicAppliedReferenceRange.fromJson(
            json["appliedReferenceRange"],
          ),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "unit": unit,
    "appliedReferenceRange": appliedReferenceRange?.toJson(),
  };
}

class CharacteristicAppliedReferenceRange {
  String? appliesTo;
  double? lowValue;
  double? highValue;

  CharacteristicAppliedReferenceRange({
    this.appliesTo,
    this.lowValue,
    this.highValue,
  });

  factory CharacteristicAppliedReferenceRange.fromJson(
    Map<String, dynamic> json,
  ) => CharacteristicAppliedReferenceRange(
    appliesTo: json["appliesTo"],
    lowValue: json["lowValue"]?.toDouble(),
    highValue: json["highValue"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "appliesTo": appliesTo,
    "lowValue": lowValue,
    "highValue": highValue,
  };
}

class TestClass {
  String? id;
  String? name;
  int? price;
  String? footNote;

  TestClass({this.id, this.name, this.price, this.footNote});

  factory TestClass.fromJson(Map<String, dynamic> json) => TestClass(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    footNote: json["footNote"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "footNote": footNote,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
