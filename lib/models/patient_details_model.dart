import 'package:pathbyte/models/caseModel.dart';

class PatientDetailsModel {
  int? code;
  String? message;
  Data? data;

  PatientDetailsModel({this.code, this.message, this.data});

  PatientDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Patient? patient;

  Data({this.patient});

  Data.fromJson(Map<String, dynamic> json) {
    patient = json['patient'] != null
        ? new Patient.fromJson(json['patient'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    return data;
  }
}
