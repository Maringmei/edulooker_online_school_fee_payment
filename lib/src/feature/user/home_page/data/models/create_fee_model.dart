// To parse this JSON data, do
//
//     final createFeeModel = createFeeModelFromJson(jsonString);

import 'dart:convert';

CreateFeeModel createFeeModelFromJson(String str) => CreateFeeModel.fromJson(json.decode(str));

String createFeeModelToJson(CreateFeeModel data) => json.encode(data.toJson());

class CreateFeeModel {
  bool? success;
  CreateFeeModelData? data;
  dynamic message;

  CreateFeeModel({
    this.success,
    this.data,
    this.message,
  });

  factory CreateFeeModel.fromJson(Map<String, dynamic> json) => CreateFeeModel(
    success: json["success"],
    data: json["data"] == null ? null : CreateFeeModelData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class CreateFeeModelData {
  String? message;
  Data? data;

  CreateFeeModelData({
    this.message,
    this.data,
  });

  factory CreateFeeModelData.fromJson(Map<String, dynamic> json) => CreateFeeModelData(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? merchId;
  String? custEmail;
  String? custMobile;
  String? returnUrl;
  String? mode;
  int? atomTokenId;

  Data({
    this.merchId,
    this.custEmail,
    this.custMobile,
    this.returnUrl,
    this.mode,
    this.atomTokenId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    merchId: json["merchId"],
    custEmail: json["custEmail"],
    custMobile: json["custMobile"],
    returnUrl: json["returnUrl"],
    mode: json["mode"],
    atomTokenId: json["atomTokenId"],
  );

  Map<String, dynamic> toJson() => {
    "merchId": merchId,
    "custEmail": custEmail,
    "custMobile": custMobile,
    "returnUrl": returnUrl,
    "mode": mode,
    "atomTokenId": atomTokenId,
  };
}
