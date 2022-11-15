// To parse this JSON data, do
//
//     final internalTransferModel = internalTransferModelFromJson(jsonString);

import 'dart:convert';

InternalTransferModel internalTransferModelFromJson(String str) => InternalTransferModel.fromJson(json.decode(str));

String internalTransferModelToJson(InternalTransferModel data) => json.encode(data.toJson());

class InternalTransferModel {
  InternalTransferModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<Datum>? data;

  InternalTransferModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      InternalTransferModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory InternalTransferModel.fromJson(Map<String, dynamic> json) => InternalTransferModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.planId,
    required this.planName,
  });

  final String? planId;
  final String? planName;

  Datum copyWith({
    String? planId,
    String? planName,
  }) =>
      Datum(
        planId: planId ?? this.planId,
        planName: planName ?? this.planName,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        planId: json["plan_id"],
        planName: json["plan_name"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "plan_name": planName,
      };
}
