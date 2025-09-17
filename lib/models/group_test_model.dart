// To parse this JSON data, do
//
//     final groupTestModel = groupTestModelFromJson(jsonString);

import 'dart:convert';

import 'package:pathbyte/models/test_model.dart';

GroupTestModel groupTestModelFromJson(String str) =>
    GroupTestModel.fromJson(json.decode(str));

String groupTestModelToJson(GroupTestModel data) => json.encode(data.toJson());

class GroupTestModel {
  var code;
  String? message;
  Data? data;

  GroupTestModel({this.code, this.message, this.data});

  factory GroupTestModel.fromJson(Map<String, dynamic> json) => GroupTestModel(
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
  List<Group>? groups;
  Pagination? pagination;

  Data({this.groups, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    groups: json["groups"] == null
        ? []
        : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "groups": groups == null
        ? []
        : List<dynamic>.from(groups!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Group {
  String? id;
  String? groupId;
  String? name;
  String? description;
  var price;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Test>? tests;

  Group({
    this.id,
    this.groupId,
    this.name,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.tests,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["_id"],
    groupId: json["groupId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    tests: json["tests"] == null
        ? []
        : List<Test>.from(json["tests"]!.map((x) => Test.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "groupId": groupId,
    "name": name,
    "description": description,
    "price": price,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "tests": tests == null
        ? []
        : List<dynamic>.from(tests!.map((x) => x.toJson())),
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
