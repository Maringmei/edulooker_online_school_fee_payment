// To parse this JSON data, do
//
//     final createFeeModel = createFeeModelFromJson(jsonString);

import 'dart:convert';

CreateFeeModel createFeeModelFromJson(String str) => CreateFeeModel.fromJson(json.decode(str));

String createFeeModelToJson(CreateFeeModel data) => json.encode(data.toJson());

class CreateFeeModel {
  bool? success;
  Data? data;
  String? message;

  CreateFeeModel({
    this.success,
    this.data,
    this.message,
  });

  factory CreateFeeModel.fromJson(Map<String, dynamic> json) => CreateFeeModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? id;
  int? atomTokenId;
  String? merchId;
  String? custEmail;
  String? custMobile;
  String? returnUrl;

  Data({
    this.id,
    this.atomTokenId,
    this.merchId,
    this.custEmail,
    this.custMobile,
    this.returnUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    atomTokenId: json["atomTokenId"],
    merchId: json["merchId"],
    custEmail: json["custEmail"],
    custMobile: json["custMobile"],
    returnUrl: json["returnUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "atomTokenId": atomTokenId,
    "merchId": merchId,
    "custEmail": custEmail,
    "custMobile": custMobile,
    "returnUrl": returnUrl,
  };
}
