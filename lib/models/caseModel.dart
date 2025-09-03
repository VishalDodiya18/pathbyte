import 'package:labapp/models/test_model.dart';

class CaseModel {
  var code;
  String? message;
  Data? data;

  CaseModel({this.code, this.message, this.data});

  CaseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
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
        cases!.add(new Cases.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cases != null) {
      data['cases'] = this.cases!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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
  var transactions;

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
        ? new Patient.fromJson(json['patient'])
        : null;
    if (json['casetests'] != null) {
      casetests = <Casetests>[];
      json['casetests'].forEach((v) {
        casetests!.add(new Casetests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caseId'] = this.caseId;
    data['patientId'] = this.patientId;
    data['status'] = this.status;
    data['referringDoctor'] = this.referringDoctor;
    data['totalAmount'] = this.totalAmount;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['finalAmount'] = this.finalAmount;
    data['amountStatus'] = this.amountStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.casetests != null) {
      data['casetests'] = this.casetests!.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
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
    this.gender,
    this.phoneNumbers,
    this.email,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patientId = json['patientId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    gender = json['gender'];
    phoneNumbers = json['phoneNumbers'].cast<String>();
    email = json['email'];
    address = json['address'] != null
        ? new Address.fromJson(json['address'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['patientId'] = this.patientId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['phoneNumbers'] = this.phoneNumbers;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
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

  Address.fromJson(Map<String, dynamic> json) {
    line1 = json['line1'];
    line2 = json['line2'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
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
        characteristics!.add(new Characteristics.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    test = json['test'] != null ? new Test.fromJson(json['test']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caseId'] = this.caseId;
    data['testId'] = this.testId;
    data['categoryId'] = this.categoryId;
    data['price'] = this.price;
    data['footNote'] = this.footNote;
    if (this.characteristics != null) {
      data['characteristics'] = this.characteristics!
          .map((v) => v.toJson())
          .toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.test != null) {
      data['test'] = this.test!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['unit'] = this.unit;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['stringValue'] = this.stringValue;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appliesTo'] = this.appliesTo;
    data['stringValue'] = this.stringValue;
    data['lowValue'] = this.lowValue;
    data['highValue'] = this.highValue;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}
