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
    required this.image,
  });

  final String status;
  final String referralCode;
  final String referralTitle;
  final String referralMsg;
  final String image;

  ReferralModel copyWith({
    String? status,
    String? referralCode,
    String? referralTitle,
    String? referralMsg,
    String? image,
  }) =>
      ReferralModel(
        status: status ?? this.status,
        referralCode: referralCode ?? this.referralCode,
        referralTitle: referralTitle ?? this.referralTitle,
        referralMsg: referralMsg ?? this.referralMsg,
        image: image ?? this.image,
      );

  factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
        status: json["status"],
        referralCode: json["referral_code"],
        referralTitle: json["referral_title"],
        referralMsg: json["referral_msg"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "referral_code": referralCode,
        "referral_title": referralTitle,
        "referral_msg": referralMsg,
      };
}
