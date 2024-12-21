// To parse this JSON data, do
//
//     final studentProfileModel = studentProfileModelFromJson(jsonString);

import 'dart:convert';

StudentProfileModel studentProfileModelFromJson(String str) =>
    StudentProfileModel.fromJson(json.decode(str));

String studentProfileModelToJson(StudentProfileModel data) =>
    json.encode(data.toJson());

class StudentProfileModel {
  bool? success;
  StudentData? data;
  dynamic message;

  StudentProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) =>
      StudentProfileModel(
        success: json["success"],
        data: json["data"] == null ? null : StudentData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class StudentData {
  String? name;
  String? registrationNo;
  String? rollNo;
  String? section;
  String? course;
  String? batch;

  StudentData({
    this.name,
    this.registrationNo,
    this.rollNo,
    this.section,
    this.course,
    this.batch,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        name: json["name"],
        registrationNo: json["registration_no"],
        rollNo: json["rollNo"],
        section: json["section"],
        course: json["course"],
        batch: json["batch"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "registration_no": registrationNo,
        "rollNo": rollNo,
        "section": section,
        "course": course,
        "batch": batch,
      };
}
