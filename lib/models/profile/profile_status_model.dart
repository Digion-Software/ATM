// To parse this JSON data, do
//
//     final profileStatusModel = profileStatusModelFromJson(jsonString);

import 'dart:convert';

ProfileStatusModel profileStatusModelFromJson(String str) => ProfileStatusModel.fromJson(json.decode(str));

String profileStatusModelToJson(ProfileStatusModel data) => json.encode(data.toJson());

class ProfileStatusModel {
  ProfileStatusModel({
    required this.userFirstName,
    required this.userLastName,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userCountry,
    required this.mobileCode,
    required this.userDob,
    required this.gender,
    required this.userAddress,
    required this.walletCode,
    required this.profileStatus,
    required this.kycStatus,
  });

  final String? userFirstName;
  final String? userLastName;
  final String? userName;
  final String? userEmail;
  final String? userPhone;
  final String? userCountry;
  final String? mobileCode;
  final String? userDob;
  final String? gender;
  final String? userAddress;
  final String? walletCode;
  final bool? profileStatus;
  final String? kycStatus;

  ProfileStatusModel copyWith({
    String? userFirstName,
    String? userLastName,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? userCountry,
    String? mobileCode,
    String? userDob,
    String? gender,
    String? userAddress,
    String? walletCode,
    bool? profileStatus,
    String? kycStatus,
  }) =>
      ProfileStatusModel(
        userFirstName: userFirstName ?? this.userFirstName,
        userLastName: userLastName ?? this.userLastName,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        userPhone: userPhone ?? this.userPhone,
        userCountry: userCountry ?? this.userCountry,
        mobileCode: mobileCode ?? this.mobileCode,
        userDob: userDob ?? this.userDob,
        gender: gender ?? this.gender,
        userAddress: userAddress ?? this.userAddress,
        walletCode: walletCode ?? this.walletCode,
        profileStatus: profileStatus ?? this.profileStatus,
        kycStatus: kycStatus ?? this.kycStatus,
      );

  factory ProfileStatusModel.fromJson(Map<String, dynamic> json) => ProfileStatusModel(
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userCountry: json["user_country"],
        mobileCode: json["mobile_code"],
        userDob: json["user_dob"],
        gender: json["gender"],
        userAddress: json["user_address"],
        walletCode: json["wallet_code"],
        profileStatus: json["profile_status"],
        kycStatus: json["kyc_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_country": userCountry,
        "mobile_code": mobileCode,
        "user_dob": userDob,
        "gender": gender,
        "user_address": userAddress,
        "wallet_code": walletCode,
        "profile_status": profileStatus,
        "kyc_status": kycStatus,
      };
}
