// To parse this JSON data, do
//
//     final sharedModel = sharedModelFromJson(jsonString);

import 'dart:convert';

SharedModel sharedModelFromJson(String str) => SharedModel.fromJson(json.decode(str));

String sharedModelToJson(SharedModel data) => json.encode(data.toJson());

class SharedModel {
  bool? success;
  dynamic data;
  String? message;

  SharedModel({
    this.success,
    this.data,
    this.message,
  });

  factory SharedModel.fromJson(Map<String, dynamic> json) => SharedModel(
    success: json["success"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
  };
}
