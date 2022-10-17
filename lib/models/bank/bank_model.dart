// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<BankDatum>? data;

  BankModel copyWith({
    String? status,
    String? message,
    List<BankDatum>? data,
  }) =>
      BankModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : List<BankDatum>.from(json["data"].map((x) => BankDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BankDatum {
  BankDatum({
    required this.userBankId,
    required this.userId,
    required this.managerId,
    required this.managerMasterId,
    required this.bankName,
    required this.bankIfsc,
    required this.bankAccountHolderName,
    required this.bankAccountNumber,
    required this.bankStatus,
    required this.addedDatetime,
    required this.isDelete,
    required this.modifiedBy,
    required this.bankLogo,
  });

  final String? userBankId;
  final String? userId;
  final String? managerId;
  final String? managerMasterId;
  final String? bankName;
  final String? bankIfsc;
  final String? bankAccountHolderName;
  final String? bankAccountNumber;
  final String? bankStatus;
  final DateTime? addedDatetime;
  final String? isDelete;
  final String? modifiedBy;
  final String? bankLogo;

  BankDatum copyWith({
    String? userBankId,
    String? userId,
    String? managerId,
    String? managerMasterId,
    String? bankName,
    String? bankIfsc,
    String? bankAccountHolderName,
    String? bankAccountNumber,
    String? bankStatus,
    DateTime? addedDatetime,
    String? isDelete,
    String? modifiedBy,
    String? bankLogo,
  }) =>
      BankDatum(
        userBankId: userBankId ?? this.userBankId,
        userId: userId ?? this.userId,
        managerId: managerId ?? this.managerId,
        managerMasterId: managerMasterId ?? this.managerMasterId,
        bankName: bankName ?? this.bankName,
        bankIfsc: bankIfsc ?? this.bankIfsc,
        bankAccountHolderName: bankAccountHolderName ?? this.bankAccountHolderName,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        bankStatus: bankStatus ?? this.bankStatus,
        addedDatetime: addedDatetime ?? this.addedDatetime,
        isDelete: isDelete ?? this.isDelete,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        bankLogo: bankLogo ?? this.bankLogo,
      );

  factory BankDatum.fromJson(Map<String, dynamic> json) => BankDatum(
        userBankId: json["user_bank_id"],
        userId: json["user_id"],
        managerId: json["manager_id"],
        managerMasterId: json["manager_master_id"],
        bankName: json["bank_name"],
        bankIfsc: json["bank_ifsc"],
        bankAccountHolderName: json["bank_account_holder_name"],
        bankAccountNumber: json["bank_account_number"],
        bankStatus: json["bank_status"],
        addedDatetime: json["added_datetime"] == null ? null : DateTime.parse(json["added_datetime"]),
        isDelete: json["is_delete"],
        modifiedBy: json["modified_by"],
        bankLogo: json["bank_logo"],
      );

  Map<String, dynamic> toJson() => {
        "user_bank_id": userBankId,
        "user_id": userId,
        "manager_id": managerId,
        "manager_master_id": managerMasterId,
        "bank_name": bankName,
        "bank_ifsc": bankIfsc,
        "bank_account_holder_name": bankAccountHolderName,
        "bank_account_number": bankAccountNumber,
        "bank_status": bankStatus,
        "added_datetime": addedDatetime == null ? null : addedDatetime!.toIso8601String(),
        "is_delete": isDelete,
        "modified_by": modifiedBy,
        "bank_logo": bankLogo,
      };
}
