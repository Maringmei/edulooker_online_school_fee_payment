// To parse this JSON data, do
//
//     final siblingModel = siblingModelFromJson(jsonString);

import 'dart:convert';

SiblingModel siblingModelFromJson(String str) =>
    SiblingModel.fromJson(json.decode(str));

String siblingModelToJson(SiblingModel data) => json.encode(data.toJson());

class SiblingModel {
  bool? success;
  List<SiblingData>? data;
  dynamic message;

  SiblingModel({
    this.success,
    this.data,
    this.message,
  });

  factory SiblingModel.fromJson(Map<String, dynamic> json) => SiblingModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SiblingData>.from(
                json["data"]!.map((x) => SiblingData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class SiblingData {
  String? registrationId;
  String? registrationNo;
  String? firstName;
  DateTime? dob;
  String? course;
  String? batch;
  String? section;
  String? rollNo;
  dynamic photoUpload;
  String? schoolId;
  String? accessToken;
  bool? feeReminder;
  String? baseUrl;

  SiblingData({
    this.registrationId,
    this.registrationNo,
    this.firstName,
    this.dob,
    this.course,
    this.batch,
    this.section,
    this.rollNo,
    this.photoUpload,
    this.schoolId,
    this.accessToken,
    this.feeReminder,
    this.baseUrl,
  });

  factory SiblingData.fromJson(Map<String, dynamic> json) => SiblingData(
        registrationId: json["registration_id"],
        registrationNo: json["registrationNo"],
        firstName: json["firstName"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        course: json["course"],
        batch: json["batch"],
        section: json["section"],
        rollNo: json["rollNo"],
        photoUpload: json["photoUpload"],
        schoolId: json["school_id"],
        accessToken: json["accessToken"],
        feeReminder: json["fee_reminder"],
        baseUrl: json["base_url"],
      );

  Map<String, dynamic> toJson() => {
        "registration_id": registrationId,
        "registrationNo": registrationNo,
        "firstName": firstName,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "course": course,
        "batch": batch,
        "section": section,
        "rollNo": rollNo,
        "photoUpload": photoUpload,
        "school_id": schoolId,
        "accessToken": accessToken,
        "fee_reminder": feeReminder,
        "base_url": baseUrl,
      };
}
