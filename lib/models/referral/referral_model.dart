// To parse this JSON data, do
//
//     final referralModel = referralModelFromJson(jsonString);

import 'dart:convert';

ReferralModel referralModelFromJson(String str) => ReferralModel.fromJson(json.decode(str));

String referralModelToJson(ReferralModel data) => json.encode(data.toJson());

class ReferralModel {
  ReferralModel({
    required this.status,
    required this.referralCode,
    required this.referralTitle,
    required this.referralMsg,
  });

  final String status;
  final String referralCode;
  final String referralTitle;
  final String referralMsg;

  ReferralModel copyWith({
    String? status,
    String? referralCode,
    String? referralTitle,
    String? referralMsg,
  }) =>
      ReferralModel(
        status: status ?? this.status,
        referralCode: referralCode ?? this.referralCode,
        referralTitle: referralTitle ?? this.referralTitle,
        referralMsg: referralMsg ?? this.referralMsg,
      );

  factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
        status: json["status"],
        referralCode: json["referral_code"],
        referralTitle: json["referral_title"],
        referralMsg: json["referral_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "referral_code": referralCode,
        "referral_title": referralTitle,
        "referral_msg": referralMsg,
      };
}
