// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.userData,
  });

  final String? status;
  final String? message;
  final UserData? userData;

  LoginModel copyWith({
    String? status,
    String? message,
    UserData? userData,
  }) =>
      LoginModel(
        status: status ?? this.status,
        message: message ?? this.message,
        userData: userData ?? this.userData,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_data": userData == null ? null : userData!.toJson(),
      };
}

class UserData {
  UserData({
    required this.userId,
    required this.authKey,
    required this.name,
    required this.email,
    required this.userPhone,
    required this.userType,
    required this.walletCode,
    required this.kycStatus,
    required this.kycStatusColor,
  });

  final String userId;
  final String authKey;
  final String name;
  final String email;
  final String userPhone;
  final String userType;
  final String walletCode;
  final String kycStatus;
  final String kycStatusColor;

  UserData copyWith({
    String? userId,
    String? authKey,
    String? name,
    String? email,
    String? userPhone,
    String? userType,
    String? walletCode,
    String? kycStatus,
    String? kycStatusColor,
  }) =>
      UserData(
        userId: userId ?? this.userId,
        authKey: authKey ?? this.authKey,
        name: name ?? this.name,
        email: email ?? this.email,
        userPhone: userPhone ?? this.userPhone,
        userType: userType ?? this.userType,
        walletCode: walletCode ?? this.walletCode,
        kycStatus: kycStatus ?? this.kycStatus,
        kycStatusColor: kycStatusColor ?? this.kycStatusColor,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["user_id"].toString(),
        authKey: json["auth_key"],
        name: json["name"],
        email: json["email"],
        userPhone: json["user_phone"],
        userType: json["user_type"].toString(),
        walletCode: json["wallet_code"].toString(),
        kycStatus: json["kyc_status"],
        kycStatusColor: json["kyc_status_color"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "auth_key": authKey,
        "name": name,
        "email": email,
        "user_phone": userPhone,
        "user_type": userType,
        "wallet_code": walletCode,
        "kyc_status": kycStatus,
        "kyc_status_color": kycStatusColor,
      };
}
