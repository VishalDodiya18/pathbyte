// To parse this JSON data, do
//
//     final patientResponseModel = patientResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:Pathbyte/models/caseModel.dart';

PatientResponseModel patientResponseModelFromJson(String str) =>
    PatientResponseModel.fromJson(json.decode(str));

String patientResponseModelToJson(PatientResponseModel data) =>
    json.encode(data.toJson());

class PatientResponseModel {
  var code;
  String? message;
  Data? data;

  PatientResponseModel({this.code, this.message, this.data});

  factory PatientResponseModel.fromJson(Map<String, dynamic> json) =>
      PatientResponseModel(
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
  List<Patient>? patients;
  Pagination? pagination;

  Data({this.patients, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    patients: json["patients"] == null
        ? []
        : List<Patient>.from(json["patients"]!.map((x) => Patient.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "patients": patients == null
        ? []
        : List<dynamic>.from(patients!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  var total;
  var page;
  var limit;
  var totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

enum City { EMPTY, METROPOLIS }

final cityValues = EnumValues({"": City.EMPTY, "Metropolis": City.METROPOLIS});

enum Country { INDIA, USA }

final countryValues = EnumValues({"India": Country.INDIA, "USA": Country.USA});

enum Line1 { MANGLA_VIHAR, THE_123_MAIN_STREET }

final line1Values = EnumValues({
  "Mangla Vihar": Line1.MANGLA_VIHAR,
  "123 Main Street": Line1.THE_123_MAIN_STREET,
});

enum Line2 { APT_4_B, EMPTY }

final line2Values = EnumValues({"Apt 4B": Line2.APT_4_B, "": Line2.EMPTY});

enum State { EMPTY, NY }

final stateValues = EnumValues({"": State.EMPTY, "NY": State.NY});

enum FirstName { JOHN, JONNY, SHUBHAM }

final firstNameValues = EnumValues({
  "John": FirstName.JOHN,
  "Jonny": FirstName.JONNY,
  "shubham": FirstName.SHUBHAM,
});

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
