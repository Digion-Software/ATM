// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    required this.status,
    required this.planData,
    required this.sliderData,
    required this.activePlans,
    required this.totalCapital,
    required this.totalEarning,
    required this.balance,
    required this.walletBalance,
  });

  final String? status;
  final List<PlanDatum>? planData;
  final List<SliderDatum>? sliderData;
  final int? activePlans;
  final int? totalCapital;
  final int? totalEarning;
  final int? balance;
  final int? walletBalance;

  DashboardModel copyWith({
    String? status,
    List<PlanDatum>? planData,
    List<SliderDatum>? sliderData,
    int? activePlans,
    int? totalCapital,
    int? totalEarning,
    int? balance,
    int? walletBalance,
  }) =>
      DashboardModel(
        status: status ?? this.status,
        planData: planData ?? this.planData,
        sliderData: sliderData ?? this.sliderData,
        activePlans: activePlans ?? this.activePlans,
        totalCapital: totalCapital ?? this.totalCapital,
        totalEarning: totalEarning ?? this.totalEarning,
        balance: balance ?? this.balance,
        walletBalance: walletBalance ?? this.walletBalance,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        status: json["status"],
        planData: json["plan_data"] == null
            ? null
            : List<PlanDatum>.from(json["plan_data"].map((x) => PlanDatum.fromJson(x))),
        sliderData: json["slider_data"] == null
            ? null
            : List<SliderDatum>.from(json["slider_data"].map((x) => SliderDatum.fromJson(x))),
        activePlans: int.parse((json["active_plans"] ?? 0).toString()),
        totalCapital: int.parse((json["total_capital"] ?? 0).toString()),
        totalEarning: int.parse((json["total_earning"] ?? 0).toString()),
        balance: int.parse((json["balance"] ?? 0).toString()),
        walletBalance: int.parse((json["wallet_balance"] ?? 0).toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "plan_data": planData == null ? null : List<dynamic>.from(planData!.map((x) => x.toJson())),
        "slider_data": sliderData == null ? null : List<dynamic>.from(sliderData!.map((x) => x.toJson())),
        "active_plans": activePlans,
        "total_capital": totalCapital,
        "total_earning": totalEarning,
        "balance": balance,
        "wallet_balance": walletBalance,
      };
}

class PlanDatum {
  PlanDatum({
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

  PlanDatum copyWith({
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
      PlanDatum(
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

  factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
        planId: json["plan_id"],
        planName: json["plan_name"],
        planDescription: json["plan_description"],
        planMinimumAmount: json["plan_minimum_amount"],
        planMonthlyMinReturn: json["plan_monthly_min_return"],
        planMonthlyMaxReturn: json["plan_monthly_max_return"],
        planBanner: json["plan_banner"],
        invested: int.parse((json["invested"] ?? 0).toString()),
        profit: int.parse((json["profit"]??0).toString()),
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

class SliderDatum {
  SliderDatum({
    required this.bannerId,
    required this.bannerName,
    required this.bannerDescription,
    required this.bannerImage,
    required this.bannerStatus,
  });

  final String? bannerId;
  final String? bannerName;
  final String? bannerDescription;
  final String? bannerImage;
  final String? bannerStatus;

  SliderDatum copyWith({
    String? bannerId,
    String? bannerName,
    String? bannerDescription,
    String? bannerImage,
    String? bannerStatus,
  }) =>
      SliderDatum(
        bannerId: bannerId ?? this.bannerId,
        bannerName: bannerName ?? this.bannerName,
        bannerDescription: bannerDescription ?? this.bannerDescription,
        bannerImage: bannerImage ?? this.bannerImage,
        bannerStatus: bannerStatus ?? this.bannerStatus,
      );

  factory SliderDatum.fromJson(Map<String, dynamic> json) => SliderDatum(
        bannerId: json["banner_id"],
        bannerName: json["banner_name"],
        bannerDescription: json["banner_description"],
        bannerImage: json["banner_image"],
        bannerStatus: json["banner_status"],
      );

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "banner_name": bannerName,
        "banner_description": bannerDescription,
        "banner_image": bannerImage,
        "banner_status": bannerStatus,
      };
}
