// To parse this JSON data, do
//
//     final caseDetailsResponse = caseDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:labapp/models/caseModel.dart';
import 'package:labapp/models/test_model.dart';

CaseDetailsResponse caseDetailsResponseFromJson(String str) =>
    CaseDetailsResponse.fromJson(json.decode(str));

String caseDetailsResponseToJson(CaseDetailsResponse data) =>
    json.encode(data.toJson());

class CaseDetailsResponse {
  int? code;
  String? message;
  Data? data;

  CaseDetailsResponse({this.code, this.message, this.data});

  factory CaseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CaseDetailsResponse(
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
  CaseDetails? dataCase;

  Data({this.dataCase});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataCase: json["case"] == null ? null : CaseDetails.fromJson(json["case"]),
  );

  Map<String, dynamic> toJson() => {"case": dataCase?.toJson()};
}

class CaseDetails {
  String? id;
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
  Patient? patient;
  Doctor? doctor;
  List<Casetest>? casetests;
  List<Transaction>? transactions;
  Labcenter? labcenter;

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
    this.patient,
    this.doctor,
    this.casetests,
    this.transactions,
    this.labcenter,
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
    patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
    doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
    casetests: json["casetests"] == null
        ? []
        : List<Casetest>.from(
            json["casetests"]!.map((x) => Casetest.fromJson(x)),
          ),
    transactions: json["transactions"] == null
        ? []
        : List<Transaction>.from(
            json["transactions"]!.map((x) => Transaction.fromJson(x)),
          ),
    labcenter: json["labcenter"] == null
        ? null
        : Labcenter.fromJson(json["labcenter"]),
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
    "patient": patient?.toJson(),
    "doctor": doctor?.toJson(),
    "casetests": casetests == null
        ? []
        : List<dynamic>.from(casetests!.map((x) => x.toJson())),
    "transactions": transactions == null
        ? []
        : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "labcenter": labcenter?.toJson(),
  };
}

class Casetest {
  String? id;
  String? caseId;
  String? testId;
  String? categoryId;
  String? unit;
  int? price;
  String? footNote;
  List<dynamic>? characteristics;
  DateTime? createdAt;
  DateTime? updatedAt;
  Test? test;
  Category? category;

  Casetest({
    this.id,
    this.caseId,
    this.testId,
    this.categoryId,
    this.unit,
    this.price,
    this.footNote,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
    this.test,
    this.category,
  });

  factory Casetest.fromJson(Map<String, dynamic> json) => Casetest(
    id: json["_id"],
    caseId: json["caseId"],
    testId: json["testId"],
    categoryId: json["categoryId"],
    unit: json["unit"],
    price: json["price"],
    footNote: json["footNote"],
    characteristics: json["characteristics"] == null
        ? []
        : List<dynamic>.from(json["characteristics"]!.map((x) => x)),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    test: json["test"] == null ? null : Test.fromJson(json["test"]),
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "caseId": caseId,
    "testId": testId,
    "categoryId": categoryId,
    "unit": unit,
    "price": price,
    "footNote": footNote,
    "characteristics": characteristics == null
        ? []
        : List<dynamic>.from(characteristics!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "test": test?.toJson(),
    "category": category?.toJson(),
  };
}

class Category {
  String? id;
  String? categoryId;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryId": categoryId,
    "name": name,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ReferenceRange {
  String? appliesTo;
  String? stringValue;

  ReferenceRange({this.appliesTo, this.stringValue});

  factory ReferenceRange.fromJson(Map<String, dynamic> json) => ReferenceRange(
    appliesTo: json["appliesTo"],
    stringValue: json["stringValue"],
  );

  Map<String, dynamic> toJson() => {
    "appliesTo": appliesTo,
    "stringValue": stringValue,
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
  DateTime? createdAt;
  DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
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
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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

class Labcenter {
  String? id;
  String? labCenterId;
  String? name;
  String? location;
  List<String>? contactNumbers;
  bool? deleted;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Labcenter({
    this.id,
    this.labCenterId,
    this.name,
    this.location,
    this.contactNumbers,
    this.deleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Labcenter.fromJson(Map<String, dynamic> json) => Labcenter(
    id: json["_id"],
    labCenterId: json["labCenterId"],
    name: json["name"],
    location: json["location"],
    contactNumbers: json["contactNumbers"] == null
        ? []
        : List<String>.from(json["contactNumbers"]!.map((x) => x)),
    deleted: json["deleted"],
    deletedAt: json["deletedAt"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "labCenterId": labCenterId,
    "name": name,
    "location": location,
    "contactNumbers": contactNumbers == null
        ? []
        : List<dynamic>.from(contactNumbers!.map((x) => x)),
    "deleted": deleted,
    "deletedAt": deletedAt,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Patient {
  String? id;
  String? patientId;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  List<String>? phoneNumbers;
  String? email;
  Address? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  Patient({
    this.id,
    this.patientId,
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.phoneNumbers,
    this.email,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["_id"],
    patientId: json["patientId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    age: json["age"],
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
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patientId": patientId,
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
    "gender": gender,
    "phoneNumbers": phoneNumbers == null
        ? []
        : List<dynamic>.from(phoneNumbers!.map((x) => x)),
    "email": email,
    "address": address?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Transaction {
  String? id;
  String? transactionId;
  String? caseId;
  var amountGiven;
  String? mode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Transaction({
    this.id,
    this.transactionId,
    this.caseId,
    this.amountGiven,
    this.mode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["_id"],
    transactionId: json["transactionId"],
    caseId: json["caseId"],
    amountGiven: json["amountGiven"],
    mode: json["mode"],
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
    "transactionId": transactionId,
    "caseId": caseId,
    "amountGiven": amountGiven,
    "mode": mode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
