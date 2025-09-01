class CaseModel {
  String? sId;
  String? caseId;
  String? patientId;
  String? status;
  String? referringDoctor;
  int? totalAmount;
  String? discountType;
  int? discountValue;
  var finalAmount;
  String? createdAt;
  String? updatedAt;
  List<Patient>? patient;
  List? doctor;
  List<Casetests>? casetests;
  List? transactions;

  CaseModel({
    this.sId,
    this.caseId,
    this.patientId,
    this.status,
    this.referringDoctor,
    this.totalAmount,
    this.discountType,
    this.discountValue,
    this.finalAmount,
    this.createdAt,
    this.updatedAt,
    this.patient,
    this.doctor,
    this.casetests,
    this.transactions,
  });

  CaseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caseId = json['caseId'];
    patientId = json['patientId'];
    status = json['status'];
    referringDoctor = json['referringDoctor'];
    totalAmount = json['totalAmount'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    finalAmount = json['finalAmount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['patient'] != null) {
      patient = <Patient>[];
      json['patient'].forEach((v) {
        patient!.add(Patient.fromJson(v));
      });
    }

    if (json['casetests'] != null) {
      casetests = <Casetests>[];
      json['casetests'].forEach((v) {
        casetests!.add(Casetests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['caseId'] = caseId;
    data['patientId'] = patientId;
    data['status'] = status;
    data['referringDoctor'] = referringDoctor;
    data['totalAmount'] = totalAmount;
    data['discountType'] = discountType;
    data['discountValue'] = discountValue;
    data['finalAmount'] = finalAmount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (patient != null) {
      data['patient'] = patient!.map((v) => v.toJson()).toList();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.map((v) => v.toJson()).toList();
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
  int? age;
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
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['patientId'] = patientId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['age'] = age;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['line1'] = line1;
    data['line2'] = line2;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}

class Casetests {
  String? sId;
  String? caseId;
  String? testId;
  String? categoryId;
  int? price;
  List<Characteristics>? characteristics;
  String? createdAt;
  String? updatedAt;
  List<Test>? test;
  List<Category>? category;
  String? footNote;
  String? unit;

  Casetests({
    this.sId,
    this.caseId,
    this.testId,
    this.categoryId,
    this.price,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
    this.test,
    this.category,
    this.footNote,
    this.unit,
  });

  Casetests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caseId = json['caseId'];
    testId = json['testId'];
    categoryId = json['categoryId'];
    price = json['price'];
    if (json['characteristics'] != null) {
      characteristics = <Characteristics>[];
      json['characteristics'].forEach((v) {
        characteristics!.add(Characteristics.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['test'] != null) {
      test = <Test>[];
      json['test'].forEach((v) {
        test!.add(Test.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    footNote = json['footNote'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['caseId'] = caseId;
    data['testId'] = testId;
    data['categoryId'] = categoryId;
    data['price'] = price;
    if (characteristics != null) {
      data['characteristics'] =
          characteristics!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (test != null) {
      data['test'] = test!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['footNote'] = footNote;
    data['unit'] = unit;
    return data;
  }
}

class Characteristics {
  String? name;
  String? unit;

  Characteristics({this.name, this.unit});

  Characteristics.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['unit'] = unit;
    return data;
  }
}

class Test {
  String? sId;
  String? testId;
  String? testCode;
  String? name;
  String? description;
  int? price;
  String? categoryId;
  List? groupIds;
  List? headerIds;
  List? packageIds;
  List<ReferenceRange>? referenceRange;
  List<String>? categories;
  bool? deleted;
  Null? deletedAt;
  List<Characteristics>? characteristics;
  String? createdAt;
  String? updatedAt;
  String? footNote;
  String? testType;
  int? reportingDays;
  List? possibleStringValues;
  List? dependecies;
  String? unit;
  int? numberValue;

  Test({
    this.sId,
    this.testId,
    this.testCode,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.groupIds,
    this.headerIds,
    this.packageIds,
    this.referenceRange,
    this.categories,
    this.deleted,
    this.deletedAt,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
    this.footNote,
    this.testType,
    this.reportingDays,
    this.possibleStringValues,
    this.dependecies,
    this.unit,
    this.numberValue,
  });

  Test.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testId = json['testId'];
    testCode = json['testCode'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];

    if (json['referenceRange'] != null) {
      referenceRange = <ReferenceRange>[];
      json['referenceRange'].forEach((v) {
        referenceRange!.add(ReferenceRange.fromJson(v));
      });
    }
    if (json["categories"] != null) {
      categories = json['categories'].cast<String>();
    }
    deleted = json['deleted'];
    deletedAt = json['deletedAt'];
    if (json['characteristics'] != null) {
      characteristics = <Characteristics>[];
      json['characteristics'].forEach((v) {
        characteristics!.add(Characteristics.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    footNote = json['footNote'];
    testType = json['testType'];
    reportingDays = json['reportingDays'];

    unit = json['unit'];
    numberValue = json['numberValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['testId'] = testId;
    data['testCode'] = testCode;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['categoryId'] = categoryId;
    if (groupIds != null) {
      data['groupIds'] = groupIds!.map((v) => v.toJson()).toList();
    }
    if (headerIds != null) {
      data['headerIds'] = headerIds!.map((v) => v.toJson()).toList();
    }
    if (packageIds != null) {
      data['packageIds'] = packageIds!.map((v) => v.toJson()).toList();
    }
    if (referenceRange != null) {
      data['referenceRange'] = referenceRange!.map((v) => v.toJson()).toList();
    }
    data['categories'] = categories;
    data['deleted'] = deleted;
    data['deletedAt'] = deletedAt;
    if (characteristics != null) {
      data['characteristics'] =
          characteristics!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['footNote'] = footNote;
    data['testType'] = testType;
    data['reportingDays'] = reportingDays;
    if (possibleStringValues != null) {
      data['possibleStringValues'] =
          possibleStringValues!.map((v) => v.toJson()).toList();
    }
    if (dependecies != null) {
      data['dependecies'] = dependecies!.map((v) => v.toJson()).toList();
    }
    data['unit'] = unit;
    data['numberValue'] = numberValue;
    return data;
  }
}

class ReferenceRange {
  String? appliesTo;
  String? normalCategory;
  int? lowValue;
  int? highValue;

  ReferenceRange({
    this.appliesTo,
    this.normalCategory,
    this.lowValue,
    this.highValue,
  });

  ReferenceRange.fromJson(Map<String, dynamic> json) {
    appliesTo = json['appliesTo'];
    normalCategory = json['normalCategory'];
    lowValue = json['lowValue'];
    highValue = json['highValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['appliesTo'] = appliesTo;
    data['normalCategory'] = normalCategory;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
