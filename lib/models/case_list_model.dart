// To parse this JSON data, do
//
//     final caseListModel = caseListModelFromJson(jsonString);

import 'dart:convert';

CaseListModel caseListModelFromJson(String str) =>
    CaseListModel.fromJson(json.decode(str));

String caseListModelToJson(CaseListModel data) => json.encode(data.toJson());

class CaseListModel {
  int? code;
  String? message;
  Data? data;

  CaseListModel({this.code, this.message, this.data});

  factory CaseListModel.fromJson(Map<String, dynamic> json) => CaseListModel(
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
  Pagination? pagination;

  Data({this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {"pagination": pagination?.toJson()};
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;
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
