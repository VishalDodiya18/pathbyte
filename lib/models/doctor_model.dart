class DoctorResponse {
  int? code;
  String? message;
  Data? data;

  DoctorResponse({this.code, this.message, this.data});

  DoctorResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<Doctor>? doctors;
  Pagination? pagination;

  Data({this.doctors, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = <Doctor>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctor.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Doctor {
  Address? address;
  String? id;
  String? doctorId;
  String? firstName;
  String? lastName;
  String? notificationStatus;
  List<String>? phoneNumbers;
  bool? deleted;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  int? age;
  String? hospitalName;
  String? description;
  String? gender;
  String? email;

  Doctor({
    this.address,
    this.id,
    this.doctorId,
    this.firstName,
    this.lastName,
    this.notificationStatus,
    this.phoneNumbers,
    this.deleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.hospitalName,
    this.description,
    this.gender,
    this.email,
  });

  Doctor.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new Address.fromJson(json['address'])
        : null;
    id = json['_id'];
    doctorId = json['doctorId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    notificationStatus = json['notificationStatus'];
    phoneNumbers = json['phoneNumbers'].cast<String>();
    deleted = json['deleted'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    age = json['age'];
    hospitalName = json['hospitalName'];
    description = json['description'];
    gender = json['gender'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['_id'] = id;
    data['doctorId'] = doctorId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['notificationStatus'] = notificationStatus;
    data['phoneNumbers'] = phoneNumbers;
    data['deleted'] = deleted;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['age'] = age;
    data['hospitalName'] = hospitalName;
    data['description'] = description;
    data['gender'] = gender;
    data['email'] = email;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line1'] = line1;
    data['line2'] = line2;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
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
