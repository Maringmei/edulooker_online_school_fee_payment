// To parse this JSON data, do
//
//     final schoolListModel = schoolListModelFromJson(jsonString);

import 'dart:convert';

SchoolListModel schoolListModelFromJson(String str) =>
    SchoolListModel.fromJson(json.decode(str));

String schoolListModelToJson(SchoolListModel data) =>
    json.encode(data.toJson());

class SchoolListModel {
  bool? success;
  List<SchoolData>? data;
  dynamic message;

  SchoolListModel({
    this.success,
    this.data,
    this.message,
  });

  factory SchoolListModel.fromJson(Map<String, dynamic> json) =>
      SchoolListModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SchoolData>.from(json["data"]!.map((x) => SchoolData.fromJson(x))),
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

class SchoolData {
  String? id;
  String? label;

  SchoolData({
    this.id,
    this.label,
  });

  factory SchoolData.fromJson(Map<String, dynamic> json) => SchoolData(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}
