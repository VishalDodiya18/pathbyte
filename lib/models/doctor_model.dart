class DoctorResponse {
  final int code;
  final String message;
  final DoctorData data;

  DoctorResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
      code: json['code'],
      message: json['message'],
      data: DoctorData.fromJson(json['data']),
    );
  }
}

class DoctorData {
  final List<Doctor> doctors;
  final Pagination pagination;

  DoctorData({required this.doctors, required this.pagination});

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      doctors: List<Doctor>.from(
        json['doctors'].map((x) => Doctor.fromJson(x)),
      ),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Doctor {
  final String id;
  final String doctorId;
  final String firstName;
  final String lastName;
  final String description;
  final int age;
  final String gender;
  final String notificationStatus;
  final String hospitalName;
  final List<String> phoneNumbers;
  final String email;
  final String createdAt;
  final String updatedAt;
  final Address address;

  Doctor({
    required this.id,
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.description,
    required this.age,
    required this.gender,
    required this.notificationStatus,
    required this.hospitalName,
    required this.phoneNumbers,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      doctorId: json['doctorId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      description: json['description'],
      age: json['age'],
      gender: json['gender'],
      notificationStatus: json['notificationStatus'],
      hospitalName: json['hospitalName'],
      phoneNumbers: List<String>.from(json['phoneNumbers']),
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line1: json['line1'],
      line2: json['line2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }
}

class Pagination {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
      hasPrevPage: json['hasPrevPage'],
    );
  }
}
