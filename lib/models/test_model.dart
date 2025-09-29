// To parse this JSON data, do
//
//     final getAllTestModel = getAllTestModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_connect/http/src/utils/utils.dart';

GetAllTestModel getAllTestModelFromJson(String str) =>
    GetAllTestModel.fromJson(json.decode(str));

String getAllTestModelToJson(GetAllTestModel data) =>
    json.encode(data.toJson());

class GetAllTestModel {
  var code;
  String? message;
  Data? data;

  GetAllTestModel({this.code, this.message, this.data});

  factory GetAllTestModel.fromJson(Map<String, dynamic> json) =>
      GetAllTestModel(
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
  List<Test>? tests;
  Pagination? pagination;

  Data({this.tests, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tests: json["tests"] == null
        ? []
        : List<Test>.from(json["tests"]!.map((x) => Test.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "tests": tests == null
        ? []
        : List<dynamic>.from(tests!.map((x) => x.toJson())),
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

class Test {
  String? id;
  String? testId;
  String? testCode;
  String? name;
  String? footNote;
  var price;
  String? categoryId;
  List<String>? groupIds;
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
  List<Category>? category;
  String? description;
  List<dynamic>? headerIds;
  List<String>? categories;
  List<String>? validationStrings;
  bool isnewpage;
  bool isfootnote;
  bool isSelect;

  Test({
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
    this.category,
    this.description,
    this.validationStrings,
    this.headerIds,
    this.categories,
    this.isnewpage = F,
    this.isfootnote = T,
    this.isSelect = T,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    isnewpage: F,
    isfootnote: T,
    isSelect: T,
    id: json["_id"],
    testId: json["testId"],
    testCode: json["testCode"],
    name: json["name"],
    footNote: json["footNote"],
    price: json["price"],
    categoryId: json["categoryId"],
    groupIds: json["groupIds"] == null
        ? []
        : List<String>.from(json["groupIds"]!.map((x) => x)),
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
    category: json["category"] == null
        ? []
        : List<Category>.from(
            json["category"]!.map((x) => Category.fromJson(x)),
          ),
    description: json["description"],
    headerIds: json["headerIds"] == null
        ? []
        : List<dynamic>.from(json["headerIds"]!.map((x) => x)),
    categories: json["categories"] == null
        ? []
        : List<String>.from(json["categories"]!.map((x) => x)),
    validationStrings: json["validationStrings"] == null
        ? []
        : List<String>.from(json["validationStrings"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "testId": testId,
    "testCode": testCode,
    "name": name,
    "footNote": footNote,
    "price": price,
    "categoryId": categoryId,
    "groupIds": groupIds == null
        ? []
        : List<dynamic>.from(groupIds!.map((x) => x)),
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
    "category": category == null
        ? []
        : List<dynamic>.from(category!.map((x) => x.toJson())),
    "description": description,
    "headerIds": headerIds == null
        ? []
        : List<dynamic>.from(headerIds!.map((x) => x)),
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x)),
    "validationStrings": validationStrings == null
        ? []
        : List<dynamic>.from(validationStrings!.map((x) => x)),
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

class Characteristic {
  String? name;
  String? unit;
  List<dynamic>? dependecies;
  List<String>? possibleStringValues;
  String? charType;
  List<ReferenceRange>? referenceRange;

  Characteristic({
    this.name,
    this.unit,
    this.dependecies,
    this.possibleStringValues,
    this.charType,
    this.referenceRange,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) => Characteristic(
    name: json["name"],
    unit: json["unit"],
    dependecies: json["dependecies"] == null
        ? []
        : List<dynamic>.from(json["dependecies"]!.map((x) => x)),
    possibleStringValues: json["possibleStringValues"] == null
        ? []
        : List<String>.from(json["possibleStringValues"]!.map((x) => x)),
    charType: json["charType"],
    referenceRange: json["referenceRange"] == null
        ? []
        : List<ReferenceRange>.from(
            json["referenceRange"]!.map((x) => ReferenceRange.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "unit": unit,
    "dependecies": dependecies == null
        ? []
        : List<dynamic>.from(dependecies!.map((x) => x)),
    "possibleStringValues": possibleStringValues == null
        ? []
        : List<dynamic>.from(possibleStringValues!.map((x) => x)),
    "charType": charType,
    "referenceRange": referenceRange == null
        ? []
        : List<dynamic>.from(referenceRange!.map((x) => x.toJson())),
  };
}

class ReferenceRange {
  String? appliesTo;
  String? stringValue;
  var lowValue;
  var highValue;
  String? normalCategory;

  ReferenceRange({
    this.appliesTo,
    this.stringValue,
    this.lowValue,
    this.highValue,
    this.normalCategory,
  });

  factory ReferenceRange.fromJson(Map<String, dynamic> json) => ReferenceRange(
    appliesTo: json["appliesTo"],
    stringValue: json["stringValue"],
    lowValue: json["lowValue"],
    highValue: json["highValue"],
    normalCategory: json["normalCategory"],
  );

  Map<String, dynamic> toJson() => {
    "appliesTo": appliesTo,
    "stringValue": stringValue,
    "lowValue": lowValue,
    "highValue": highValue,
    "normalCategory": normalCategory,
  };
}
