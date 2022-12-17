// To parse this JSON data, do
//
//     final depositStatusModel = depositStatusModelFromJson(jsonString);

import 'dart:convert';

DepositStatusModel depositStatusModelFromJson(String str) => DepositStatusModel.fromJson(json.decode(str));

String depositStatusModelToJson(DepositStatusModel data) => json.encode(data.toJson());

class DepositStatusModel {
  DepositStatusModel({
    required this.status,
    required this.message,
    required this.depositStatus,
  });

  final String status;
  final String message;
  final String depositStatus;

  DepositStatusModel copyWith({
    String? status,
    String? message,
    String? depositStatus,
  }) =>
      DepositStatusModel(
        status: status ?? this.status,
        message: message ?? this.message,
        depositStatus: depositStatus ?? this.depositStatus,
      );

  factory DepositStatusModel.fromJson(Map<String, dynamic> json) => DepositStatusModel(
        status: json["status"],
        message: json["message"],
        depositStatus: json["deposit_status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "deposit_status": depositStatus,
      };
}
