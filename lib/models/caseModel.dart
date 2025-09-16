// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:Pathbyte/models/case_details_model.dart';
import 'package:Pathbyte/models/test_model.dart';

class CaseModel {
  var code;
  String? message;
  Data? data;

  CaseModel({this.code, this.message, this.data});

  CaseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Cases>? cases;
  Pagination? pagination;

  Data({this.cases, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cases'] != null) {
      cases = <Cases>[];
      json['cases'].forEach((v) {
        cases!.add(Cases.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cases != null) {
      data['cases'] = cases!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Cases {
  String? sId;
  String? caseId;
  String? patientId;
  String? status;
  String? referringDoctor;
  var totalAmount;
  String? discountType;
  var discountValue;
  var finalAmount;
  String? amountStatus;
  String? createdAt;
  String? updatedAt;
  Patient? patient;
  List<Casetests>? casetests;
  List<Transaction>? transactions;

  Cases({
    this.sId,
    this.caseId,
    this.patientId,
    this.status,
    this.referringDoctor,
    this.totalAmount,
    this.discountType,
    this.discountValue,
    this.finalAmount,
    this.amountStatus,
    this.createdAt,
    this.updatedAt,
    this.patient,
    this.casetests,
    this.transactions,
  });

  Cases.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caseId = json['caseId'];
    patientId = json['patientId'];
    status = json['status'];
    referringDoctor = json['referringDoctor'];
    totalAmount = json['totalAmount'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    finalAmount = json['finalAmount'];
    amountStatus = json['amountStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patient = json['patient'] != null
        ? Patient.fromJson(json['patient'])
        : null;
    transactions = json["transactions"] == null
        ? []
        : List<Transaction>.from(
            json["transactions"]!.map((x) => Transaction.fromJson(x)),
          );
    if (json['casetests'] != null) {
      casetests = <Casetests>[];
      json['casetests'].forEach((v) {
        casetests!.add(Casetests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['caseId'] = caseId;
    data['patientId'] = patientId;
    data['status'] = status;
    data['referringDoctor'] = referringDoctor;
    data['totalAmount'] = totalAmount;
    data['discountType'] = discountType;
    data['discountValue'] = discountValue;
    data['finalAmount'] = finalAmount;
    data['amountStatus'] = amountStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (casetests != null) {
      data['casetests'] = casetests!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patient {
  String? sId;
  String? patientId;
  String? firstName;
  String? lastName;
  var age;
  var days;
  var months;
  var title;
  String? gender;
  List<String>? phoneNumbers;
  String? email;
  Address? address;
  String? createdAt;
  String? updatedAt;

  Patient({
    this.sId,
    this.patientId,
    this.firstName,
    this.lastName,
    this.age,
    this.months,
    this.days,
    this.gender,
    this.phoneNumbers,
    this.email,
    this.address,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patientId = json['patientId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    months = json['months'] ?? 0;
    days = json['days'] ?? 0;
    gender = json['gender'];
    title = json['title'] ?? "Mr.";
    phoneNumbers = json['phoneNumbers'].cast<String>();
    email = json['email'];
    address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['patientId'] = patientId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['age'] = age;
    data['days'] = days;
    data['months'] = months;
    data['title'] = title;
    data['gender'] = gender;
    data['phoneNumbers'] = phoneNumbers;
    data['email'] = email;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Casetests {
  String? sId;
  String? caseId;
  String? testId;
  String? categoryId;
  var price;
  String? footNote;
  List<Characteristics>? characteristics;
  String? createdAt;
  String? updatedAt;
  Test? test;
  Category? category;
  String? unit;

  Casetests({
    this.sId,
    this.caseId,
    this.testId,
    this.categoryId,
    this.price,
    this.footNote,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
    this.test,
    this.category,
    this.unit,
  });

  Casetests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caseId = json['caseId'];
    testId = json['testId'];
    categoryId = json['categoryId'];
    price = json['price'];
    footNote = json['footNote'];
    if (json['characteristics'] != null) {
      characteristics = <Characteristics>[];
      json['characteristics'].forEach((v) {
        characteristics!.add(Characteristics.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    test = json['test'] != null ? Test.fromJson(json['test']) : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['caseId'] = caseId;
    data['testId'] = testId;
    data['categoryId'] = categoryId;
    data['price'] = price;
    data['footNote'] = footNote;
    if (characteristics != null) {
      data['characteristics'] = characteristics!
          .map((v) => v.toJson())
          .toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (test != null) {
      data['test'] = test!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['unit'] = unit;
    return data;
  }
}

class Characteristics {
  String? name;
  String? unit;
  String? stringValue;

  Characteristics({this.name, this.unit, this.stringValue});

  Characteristics.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unit = json['unit'];
    stringValue = json['stringValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['unit'] = unit;
    data['stringValue'] = stringValue;
    return data;
  }
}

class ReferenceRange {
  String? appliesTo;
  String? stringValue;
  var lowValue;
  var highValue;

  ReferenceRange({
    this.appliesTo,
    this.stringValue,
    this.lowValue,
    this.highValue,
  });

  ReferenceRange.fromJson(Map<String, dynamic> json) {
    appliesTo = json['appliesTo'];
    stringValue = json['stringValue'];
    lowValue = json['lowValue'];
    highValue = json['highValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appliesTo'] = appliesTo;
    data['stringValue'] = stringValue;
    data['lowValue'] = lowValue;
    data['highValue'] = highValue;
    return data;
  }
}

class Category {
  String? sId;
  String? categoryId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Category({
    this.sId,
    this.categoryId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
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

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    return data;
  }
}
