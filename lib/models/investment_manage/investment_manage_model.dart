// To parse this JSON data, do
//
//     final investmentManageModel = investmentManageModelFromJson(jsonString);

import 'dart:convert';

InvestmentManageModel investmentManageModelFromJson(String str) => InvestmentManageModel.fromJson(json.decode(str));

String investmentManageModelToJson(InvestmentManageModel data) => json.encode(data.toJson());

class InvestmentManageModel {
  InvestmentManageModel({
    required this.status,
    required this.investmentId,
    required this.message,
  });

  final String? status;
  final int? investmentId;
  final String? message;

  InvestmentManageModel copyWith({
    String? status,
    int? investmentId,
    String? message,
  }) =>
      InvestmentManageModel(
        status: status ?? this.status,
        investmentId: investmentId ?? this.investmentId,
        message: message ?? this.message,
      );

  factory InvestmentManageModel.fromJson(Map<String, dynamic> json) => InvestmentManageModel(
    status: json["status"],
    investmentId: json["investment_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "investment_id": investmentId,
    "message": message,
  };
}
