// To parse this JSON data, do
//
//     final feeTotalMultipleModel = feeTotalMultipleModelFromJson(jsonString);

import 'dart:convert';

FeeTotalMultipleModel feeTotalMultipleModelFromJson(String str) =>
    FeeTotalMultipleModel.fromJson(json.decode(str));

String feeTotalMultipleModelToJson(FeeTotalMultipleModel data) =>
    json.encode(data.toJson());

class FeeTotalMultipleModel {
  bool? success;
  FeeTotal? data;
  dynamic message;

  FeeTotalMultipleModel({
    this.success,
    this.data,
    this.message,
  });

  factory FeeTotalMultipleModel.fromJson(Map<String, dynamic> json) =>
      FeeTotalMultipleModel(
        success: json["success"],
        data: json["data"] == null ? null : FeeTotal.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class FeeTotal {
  int? totalFee;
  int? discount;
  int? fine;
  int? payable;

  FeeTotal({
    this.totalFee,
    this.discount,
    this.fine,
    this.payable,
  });

  factory FeeTotal.fromJson(Map<String, dynamic> json) => FeeTotal(
        totalFee: json["total_fee"],
        discount: json["discount"],
        fine: json["fine"],
        payable: json["payable"],
      );

  Map<String, dynamic> toJson() => {
        "total_fee": totalFee,
        "discount": discount,
        "fine": fine,
        "payable": payable,
      };
}
