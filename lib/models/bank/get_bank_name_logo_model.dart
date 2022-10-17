// To parse this JSON data, do
//
//     final getBankNameLogoModel = getBankNameLogoModelFromJson(jsonString);

import 'dart:convert';

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

class BankDatum {
  BankDatum({
    required this.id,
    required this.bankName,
    required this.bankLogo,
  });

  final String? id;
  final String? bankName;
  final String? bankLogo;

  BankDatum copyWith({
    String? id,
    String? bankName,
    String? bankLogo,
  }) =>
      BankDatum(
        id: id ?? this.id,
        bankName: bankName ?? this.bankName,
        bankLogo: bankLogo ?? this.bankLogo,
      );

  factory BankDatum.fromJson(Map<String, dynamic> json) => BankDatum(
    id: json["id"],
    bankName: json["bank_name"],
    bankLogo: json["bank_logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "bank_logo": bankLogo,
  };
}
