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
  var code;
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
  String? id;
  String? caseId;
  String? patientId;
  String? status;
  String? referringDoctor;
  String? center;
  var totalAmount;
  String? discountType;
  var discountValue;
  var finalAmount;
  String? amountStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;
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
    id: json["_id"],
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
    "_id": id,
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
  var age;
  String? gender;
  String? notificationStatus;
  String? hospitalName;
  List<String>? phoneNumbers;
  String? email;
  Address? address;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;

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

class Patient {
  String? id;
  String? patientId;
  String? firstName;
  String? lastName;
  var age;
  var days;
  var months;
  String? gender;
  List<String>? phoneNumbers;
  String? email;
  Address? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;
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
  String? id;
  String? name;
  List<GroupedTest>? groupedTests;
  List<Test>? ungroupedTests;

  Category({this.id, this.name, this.groupedTests, this.ungroupedTests});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
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
    "_id": id,
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
  String? caseId;
  String? testId;
  String? categoryId;
  String? groupId;
  String? unit;
  var price;
  var numberValue;
  var stringValue;
  String? footNote;
  List<Characteristic>? characteristics;
  DateTime? createdAt;
  DateTime? updatedAt;
  TestClass? test;
  AppliedReferenceRange? appliedReferenceRange;
  TextEditingController highvalue = TextEditingController();
  TextEditingController lowvalue = TextEditingController();

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
    this.numberValue,
    this.stringValue,
    this.createdAt,
    this.updatedAt,
    this.test,

    this.appliedReferenceRange,
    TextEditingController? highvalue,
    TextEditingController? lowvalue,
  }) : highvalue = highvalue ?? TextEditingController(),
       lowvalue = lowvalue ?? TextEditingController();

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["_id"],
    numberValue: json['numberValue'],
    stringValue: json["stringValue"],

    lowvalue: TextEditingController(
      text: json['numberValue'] != null && json['numberValue'] != 0
          ? json['numberValue'].toString()
          : json["stringValue"],
    ),
    caseId: json["caseId"],
    testId: json["testId"],
    categoryId: json["categoryId"],
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
        : AppliedReferenceRange.fromJson(json["appliedReferenceRange"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "caseId": caseId,
    "testId": testId,
    "categoryId": categoryId,
    "groupId": groupId,
    "unit": unit,
    "numberValue": numberValue,
    "stringValue": stringValue,

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

class AppliedReferenceRange {
  String? appliesTo;
  var stringValue;
  var numberValue;
  var highValue;
  var lowValue;

  AppliedReferenceRange({
    this.appliesTo,
    this.stringValue,
    this.numberValue,
    this.highValue,
    this.lowValue,
  });

  factory AppliedReferenceRange.fromJson(Map<String, dynamic> json) =>
      AppliedReferenceRange(
        appliesTo: json["appliesTo"],
        stringValue: json["stringValue"],
        numberValue: json["numberValue"],
        highValue: json["highValue"],
        lowValue: json["lowValue"],
      );

  Map<String, dynamic> toJson() => {
    "appliesTo": appliesTo,
    "stringValue": stringValue,
    "numberValue": numberValue,
    "highValue": highValue,
    "lowValue": lowValue,
  };
}

// class Characteristic {
//   String? name;
//   String? unit;
//   ReferenceRange? appliedReferenceRange;
//   Characteristic({
//     this.name,
//     this.unit,
//     this.appliedReferenceRange,
//   });
//   factory Characteristic.fromJson(Map<String, dynamic> json) =>
//       Characteristic(
//         name: json["name"],
//         unit: json["unit"],
//         appliedReferenceRange: json["appliedReferenceRange"] == null
//             ? null
//             : ReferenceRange.fromJson(json["appliedReferenceRange"]),
//       );
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "unit": unit,
//     "appliedReferenceRange": appliedReferenceRange?.toJson(),
//   };
// }

class ReferenceRange {
  String? appliesTo;
  var lowValue;
  var highValue;
  String? stringValue;

  ReferenceRange({
    this.appliesTo,
    this.lowValue,
    this.highValue,
    this.stringValue,
  });

  factory ReferenceRange.fromJson(Map<String, dynamic> json) => ReferenceRange(
    appliesTo: json["appliesTo"],
    lowValue: json["lowValue"],
    highValue: json["highValue"],
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "appliesTo": appliesTo,
    "lowValue": lowValue,
    "highValue": highValue,
    "stringValue": stringValue,
  };
}

class TestClass {
  String? id;
  String? testId;
  String? testCode;
  String? name;
  String? footNote;
  var price;
  String? categoryId;
  List? groupIds;
  List<dynamic>? packageIds;
  String? testType;
  var reportingDays;
  String? unit;
  var numberValue;
  List<ReferenceRange>? referenceRange;
  List<dynamic>? possibleStringValues;
  List<dynamic>? dependecies;
  bool? deleted;
  dynamic deletedAt;
  List<Characteristic>? characteristics;
  DateTime? createdAt;
  DateTime? updatedAt;
  var v;

  TestClass({
    this.id,
    this.testId,
    this.testCode,
    this.name,
    this.footNote,
    this.price,
    this.categoryId,
    this.groupIds,
    this.packageIds,
    this.testType,
    this.reportingDays,
    this.unit,
    this.numberValue,
    this.referenceRange,
    this.possibleStringValues,
    this.dependecies,
    this.deleted,
    this.deletedAt,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TestClass.fromJson(Map<String, dynamic> json) => TestClass(
    id: json["_id"],
    testId: json["testId"],
    testCode: json["testCode"],
    name: json["name"],
    footNote: json["footNote"],
    price: json["price"],
    categoryId: json["categoryId"],
    groupIds: json["groupIds"] ?? [],
    packageIds: json["packageIds"] == null
        ? []
        : List<dynamic>.from(json["packageIds"]!.map((x) => x)),
    testType: json["testType"],
    reportingDays: json["reportingDays"],
    unit: json["unit"],
    numberValue: json["numberValue"],
    referenceRange: json["referenceRange"] == null
        ? []
        : List<ReferenceRange>.from(
            json["referenceRange"]!.map((x) => ReferenceRange.fromJson(x)),
          ),
    possibleStringValues: json["possibleStringValues"] == null
        ? []
        : List<dynamic>.from(json["possibleStringValues"]!.map((x) => x)),
    dependecies: json["dependecies"] == null
        ? []
        : List<dynamic>.from(json["dependecies"]!.map((x) => x)),
    deleted: json["deleted"],
    deletedAt: json["deletedAt"],
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
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "testId": testId,
    "testCode": testCode,
    "name": name,
    "footNote": footNote,
    "price": price,
    "categoryId": categoryId,
    "groupIds": groupIds ?? [],
    "packageIds": packageIds == null
        ? []
        : List<dynamic>.from(packageIds!.map((x) => x)),
    "testType": testType,
    "reportingDays": reportingDays,
    "unit": unit,
    "numberValue": numberValue,
    "referenceRange": referenceRange == null
        ? []
        : List<dynamic>.from(referenceRange!.map((x) => x.toJson())),
    "possibleStringValues": possibleStringValues == null
        ? []
        : List<dynamic>.from(possibleStringValues!.map((x) => x)),
    "dependecies": dependecies == null
        ? []
        : List<dynamic>.from(dependecies!.map((x) => x)),
    "deleted": deleted,
    "deletedAt": deletedAt,
    "characteristics": characteristics == null
        ? []
        : List<dynamic>.from(characteristics!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Characteristic {
  String? sId;
  String? name;
  String? unit;
  List<dynamic>? dependecies;
  List<String>? possibleStringValues;
  String? charType;
  var numberValue;
  var stringValue;
  List<ReferenceRange>? referenceRange;
  ReferenceRange? appliedReferenceRange;
  TextEditingController highvalue = TextEditingController();
  TextEditingController lowvalue = TextEditingController();

  Characteristic({
    this.name,
    this.sId,

    this.unit,
    this.dependecies,
    this.possibleStringValues,
    this.charType,
    this.referenceRange,
    this.numberValue,
    this.stringValue,
    this.appliedReferenceRange,
    TextEditingController? highvalue,
    TextEditingController? lowvalue,
  }) : highvalue = highvalue ?? TextEditingController(),
       lowvalue = lowvalue ?? TextEditingController();

  factory Characteristic.fromJson(Map<String, dynamic> json) => Characteristic(
    sId: json['_id'],
    numberValue: json['numberValue'],
    stringValue: json["stringValue"],

    lowvalue: TextEditingController(
      text: json['numberValue'] != null && json['numberValue'] != 0
          ? json['numberValue'].toString()
          : json["stringValue"],
    ),
    name: json["name"],
    unit: json["unit"],
    dependecies: json["dependecies"] == null
        ? []
        : List<dynamic>.from(json["dependecies"]!.map((x) => x)),
    possibleStringValues: json["possibleStringValues"] == null
        ? []
        : List<String>.from(json["possibleStringValues"]!.map((x) => x)),
    appliedReferenceRange: json["appliedReferenceRange"] == null
        ? null
        : ReferenceRange.fromJson(json["appliedReferenceRange"]),
    charType: json["charType"],
    referenceRange: json["referenceRange"] == null
        ? []
        : List<ReferenceRange>.from(
            json["referenceRange"]!.map((x) => ReferenceRange.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": sId,
    "unit": unit,
    "dependecies": dependecies == null
        ? []
        : List<dynamic>.from(dependecies!.map((x) => x)),
    "possibleStringValues": possibleStringValues == null
        ? []
        : List<dynamic>.from(possibleStringValues!.map((x) => x)),
    "charType": charType,
    "appliedReferenceRange": appliedReferenceRange?.toJson(),
    "referenceRange": referenceRange == null
        ? []
        : List<dynamic>.from(referenceRange!.map((x) => x.toJson())),
  };
}
