class LabCenterResponse {
  final int code;
  final String message;
  final LabData data;

  LabCenterResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LabCenterResponse.fromJson(Map<String, dynamic> json) {
    return LabCenterResponse(
      code: json['code'],
      message: json['message'],
      data: LabData.fromJson(json['data']),
    );
  }
}

class LabData {
  final List<Lab> labs;
  final Pagination pagination;

  LabData({required this.labs, required this.pagination});

  factory LabData.fromJson(Map<String, dynamic> json) {
    return LabData(
      labs: List<Lab>.from(json['labs'].map((x) => Lab.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Lab {
  final String id;
  final String labCenterId;
  final String name;
  final String location;
  final List<String> contactNumbers;
  final bool deleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  var v;

  Lab({
    required this.id,
    required this.labCenterId,
    required this.name,
    required this.location,
    required this.contactNumbers,
    required this.deleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Lab.fromJson(Map<String, dynamic> json) {
    return Lab(
      id: json['_id'],
      labCenterId: json['labCenterId'],
      name: json['name'],
      location: json['location'],
      contactNumbers: List<String>.from(json['contactNumbers']),
      deleted: json['deleted'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'labCenterId': labCenterId,
      'name': name,
      'location': location,
      'contactNumbers': contactNumbers,
      'deleted': deleted,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
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
