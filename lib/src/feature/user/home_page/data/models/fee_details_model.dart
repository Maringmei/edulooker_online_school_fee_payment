// To parse this JSON data, do
//
//     final feeDetailsModel = feeDetailsModelFromJson(jsonString);

import 'dart:convert';

FeeDetailsModel feeDetailsModelFromJson(String str) =>
    FeeDetailsModel.fromJson(json.decode(str));

String feeDetailsModelToJson(FeeDetailsModel data) =>
    json.encode(data.toJson());

class FeeDetailsModel {
  bool? success;
  List<FeeData>? data;
  String? message;

  FeeDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory FeeDetailsModel.fromJson(Map<String, dynamic> json) =>
      FeeDetailsModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<FeeData>.from(json["data"]!.map((x) => FeeData.fromJson(x))),
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

class FeeData {
  String? id;
  String? recievedAmount;
  String? feeId;
  String? paymentOf;
  String? paymentFor;
  String? status;
  String? statusDesp;
  String? feeExempted;
  String? receivedDate;
  String? receiptNo;
  ExtraFee? extraFee;

  FeeData({
    this.id,
    this.recievedAmount,
    this.feeId,
    this.paymentOf,
    this.paymentFor,
    this.status,
    this.statusDesp,
    this.feeExempted,
    this.receivedDate,
    this.receiptNo,
    this.extraFee,
  });

  factory FeeData.fromJson(Map<String, dynamic> json) => FeeData(
        id: json["id"],
        recievedAmount: json["recievedAmount"],
        feeId: json["feeId"],
        paymentOf: json["payment_of"],
        paymentFor: json["payment_for"],
        status: json["status"],
        statusDesp: json["status_desp"],
        feeExempted: json["feeExempted"],
        receivedDate: json["receivedDate"],
        receiptNo: json["receiptNo"],
        extraFee: json["extra_fee"] == null
            ? null
            : ExtraFee.fromJson(json["extra_fee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recievedAmount": recievedAmount,
        "feeId": feeId,
        "payment_of": paymentOf,
        "payment_for": paymentFor,
        "status": status,
        "status_desp": statusDesp,
        "feeExempted": feeExempted,
        "receivedDate": receivedDate,
        "receiptNo": receiptNo,
        "extra_fee": extraFee?.toJson(),
      };
}

class ExtraFee {
  String? fee;
  String? fine;
  String? disc;
  String? pay;
  List<dynamic>? defParts;

  ExtraFee({
    this.fee,
    this.fine,
    this.disc,
    this.pay,
    this.defParts,
  });

  factory ExtraFee.fromJson(Map<String, dynamic> json) => ExtraFee(
        fee: json["fee"],
        fine: json["fine"],
        disc: json["disc"],
        pay: json["pay"],
        defParts: json["defParts"] == null
            ? []
            : List<dynamic>.from(json["defParts"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fee": fee,
        "fine": fine,
        "disc": disc,
        "pay": pay,
        "defParts":
            defParts == null ? [] : List<dynamic>.from(defParts!.map((x) => x)),
      };
}

// // To parse this JSON data, do
// //
// //     final feeDetailsModel = feeDetailsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// FeeDetailsModel feeDetailsModelFromJson(String str) =>
//     FeeDetailsModel.fromJson(json.decode(str));
//
// String feeDetailsModelToJson(FeeDetailsModel data) =>
//     json.encode(data.toJson());
//
// class FeeDetailsModel {
//   bool? success;
//   List<FeeData>? data;
//   String? message;
//
//   FeeDetailsModel({
//     this.success,
//     this.data,
//     this.message,
//   });
//
//   factory FeeDetailsModel.fromJson(Map<String, dynamic> json) =>
//       FeeDetailsModel(
//         success: json["success"],
//         data: json["data"] == null
//             ? []
//             : List<FeeData>.from(json["data"]!.map((x) => FeeData.fromJson(x))),
//         message: json["message"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//       };
// }
//
// class FeeData {
//   String? id;
//   String? recievedAmount;
//   String? feeId;
//   String? paymentOf;
//   String? paymentFor;
//   String? status;
//   String? statusDesp;
//   String? feeExempted;
//   String? receivedDate;
//   String? receiptNo;
//   ExtraFee? extraFee;
//
//   FeeData({
//     this.id,
//     this.recievedAmount,
//     this.feeId,
//     this.paymentOf,
//     this.paymentFor,
//     this.status,
//     this.statusDesp,
//     this.feeExempted,
//     this.receivedDate,
//     this.receiptNo,
//     this.extraFee,
//   });
//
//   factory FeeData.fromJson(Map<String, dynamic> json) => FeeData(
//         id: json["id"],
//         recievedAmount: json["recievedAmount"],
//         feeId: json["feeId"],
//         paymentOf: json["payment_of"],
//         paymentFor: json["payment_for"],
//         status: json["status"],
//         statusDesp: json["status_desp"],
//         feeExempted: json["feeExempted"],
//         receivedDate: json["receivedDate"],
//         receiptNo: json["receiptNo"],
//         extraFee: json["extra_fee"] == null
//             ? null
//             : ExtraFee.fromJson(json["extra_fee"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "recievedAmount": recievedAmount,
//         "feeId": feeId,
//         "payment_of": paymentOf,
//         "payment_for": paymentFor,
//         "status": status,
//         "status_desp": statusDesp,
//         "feeExempted": feeExempted,
//         "receivedDate": receivedDate,
//         "receiptNo": receiptNo,
//         "extra_fee": extraFee?.toJson(),
//       };
// }
//
// class ExtraFee {
//   String? fee;
//   String? fine;
//   String? disc;
//   String? pay;
//   List<dynamic>? defParts;
//
//   ExtraFee({
//     this.fee,
//     this.fine,
//     this.disc,
//     this.pay,
//     this.defParts,
//   });
//
//   factory ExtraFee.fromJson(Map<String, dynamic> json) => ExtraFee(
//         fee: json["fee"],
//         fine: json["fine"],
//         disc: json["disc"],
//         pay: json["pay"],
//         defParts: json["defParts"] == null
//             ? []
//             : List<dynamic>.from(json["defParts"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "fee": fee,
//         "fine": fine,
//         "disc": disc,
//         "pay": pay,
//         "defParts":
//             defParts == null ? [] : List<dynamic>.from(defParts!.map((x) => x)),
//       };
// }
