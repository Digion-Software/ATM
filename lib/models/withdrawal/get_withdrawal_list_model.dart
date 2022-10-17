// To parse this JSON data, do
//
//     final getWithdrawalListModel = getWithdrawalListModelFromJson(jsonString);

import 'dart:convert';

GetWithdrawalListModel getWithdrawalListModelFromJson(String str) => GetWithdrawalListModel.fromJson(json.decode(str));

String getWithdrawalListModelToJson(GetWithdrawalListModel data) => json.encode(data.toJson());

class GetWithdrawalListModel {
  GetWithdrawalListModel({
    required this.status,
    required this.withdrawalData,
  });

  final String? status;
  final List<WithdrawalDatum>? withdrawalData;

  GetWithdrawalListModel copyWith({
    String? status,
    List<WithdrawalDatum>? withdrawalData,
  }) =>
      GetWithdrawalListModel(
        status: status ?? this.status,
        withdrawalData: withdrawalData ?? this.withdrawalData,
      );

  factory GetWithdrawalListModel.fromJson(Map<String, dynamic> json) => GetWithdrawalListModel(
        status: json["status"],
        withdrawalData: json["withdrawal_data"] == null
            ? null
            : List<WithdrawalDatum>.from(json["withdrawal_data"].map((x) => WithdrawalDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "withdrawal_data": withdrawalData == null ? null : List<dynamic>.from(withdrawalData!.map((x) => x.toJson())),
      };
}

class WithdrawalDatum {
  WithdrawalDatum({
    required this.planId,
    required this.planName,
    required this.planDescription,
    required this.planMinimumAmount,
    required this.planMonthlyMinReturn,
    required this.planMonthlyMaxReturn,
    required this.planBanner,
    required this.invested,
    required this.profit,
  });

  final String? planId;
  final String? planName;
  final String? planDescription;
  final String? planMinimumAmount;
  final String? planMonthlyMinReturn;
  final String? planMonthlyMaxReturn;
  final String? planBanner;
  final int? invested;
  final int? profit;

  WithdrawalDatum copyWith({
    String? planId,
    String? planName,
    String? planDescription,
    String? planMinimumAmount,
    String? planMonthlyMinReturn,
    String? planMonthlyMaxReturn,
    String? planBanner,
    int? invested,
    int? profit,
  }) =>
      WithdrawalDatum(
        planId: planId ?? this.planId,
        planName: planName ?? this.planName,
        planDescription: planDescription ?? this.planDescription,
        planMinimumAmount: planMinimumAmount ?? this.planMinimumAmount,
        planMonthlyMinReturn: planMonthlyMinReturn ?? this.planMonthlyMinReturn,
        planMonthlyMaxReturn: planMonthlyMaxReturn ?? this.planMonthlyMaxReturn,
        planBanner: planBanner ?? this.planBanner,
        invested: invested ?? this.invested,
        profit: profit ?? this.profit,
      );

  factory WithdrawalDatum.fromJson(Map<String, dynamic> json) => WithdrawalDatum(
        planId: json["plan_id"],
        planName: json["plan_name"],
        planDescription: json["plan_description"],
        planMinimumAmount: json["plan_minimum_amount"],
        planMonthlyMinReturn: json["plan_monthly_min_return"],
        planMonthlyMaxReturn: json["plan_monthly_max_return"],
        planBanner: json["plan_banner"],
        invested: int.parse((json["invested"] ?? 0).toString()),
        profit: int.parse((json["profit"] ?? 0).toString()),
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "plan_name": planName,
        "plan_description": planDescription,
        "plan_minimum_amount": planMinimumAmount,
        "plan_monthly_min_return": planMonthlyMinReturn,
        "plan_monthly_max_return": planMonthlyMaxReturn,
        "plan_banner": planBanner,
        "invested": invested,
        "profit": profit,
      };
}
