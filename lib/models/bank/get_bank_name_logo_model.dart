// To parse this JSON data, do
//
//     final getBankNameLogoModel = getBankNameLogoModelFromJson(jsonString);

import 'dart:convert';

import 'package:atm/models/bank/bank_model.dart';

GetBankNameLogoModel getBankNameLogoModelFromJson(String str) => GetBankNameLogoModel.fromJson(json.decode(str));

String getBankNameLogoModelToJson(GetBankNameLogoModel data) => json.encode(data.toJson());

class GetBankNameLogoModel {
  GetBankNameLogoModel({
    required this.status,
    required this.bankData,
  });

  final String? status;
  final List<BankDatum>? bankData;

  GetBankNameLogoModel copyWith({
    String? status,
    List<BankDatum>? bankData,
  }) =>
      GetBankNameLogoModel(
        status: status ?? this.status,
        bankData: bankData ?? this.bankData,
      );

  factory GetBankNameLogoModel.fromJson(Map<String, dynamic> json) => GetBankNameLogoModel(
    status: json["status"],
    bankData: json["bank_data"] == null ? null : List<BankDatum>.from(json["bank_data"].map((x) => BankDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "bank_data": bankData == null ? null : List<dynamic>.from(bankData!.map((x) => x.toJson())),
  };
}