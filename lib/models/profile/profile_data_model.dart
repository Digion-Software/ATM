// To parse this JSON data, do
//
//     final profileDataModel = profileDataModelFromJson(jsonString);

import 'dart:convert';

ProfileDataModel profileDataModelFromJson(String str) => ProfileDataModel.fromJson(json.decode(str));

String profileDataModelToJson(ProfileDataModel data) => json.encode(data.toJson());

class ProfileDataModel {
  ProfileDataModel({
    required this.status,
    required this.transactionData,
    required this.totalCapital,
  });

  final String? status;
  final TransactionData? transactionData;
  final int? totalCapital;

  ProfileDataModel copyWith({
    String? status,
    TransactionData? transactionData,
    int? totalCapital,
  }) =>
      ProfileDataModel(
        status: status ?? this.status,
        transactionData: transactionData ?? this.transactionData,
        totalCapital: totalCapital ?? this.totalCapital,
      );

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
        status: json["status"],
        transactionData: json["transaction_data"] == null ? null : TransactionData.fromJson(json["transaction_data"]),
        totalCapital: int.parse((json["total_capital"] ?? 0).toString()),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "transaction_data": transactionData == null ? null : transactionData!.toJson(),
        "total_capital": totalCapital,
      };
}

class TransactionData {
  TransactionData({
    required this.userId,
    required this.firstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPhone,
  });

  final String userId;
  final String firstName;
  final String userLastName;
  final String userEmail;
  final String userPhone;

  TransactionData copyWith({
    String? userId,
    String? firstName,
    String? userLastName,
    String? userEmail,
    String? userPhone,
  }) =>
      TransactionData(
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        userLastName: userLastName ?? this.userLastName,
        userEmail: userEmail ?? this.userEmail,
        userPhone: userPhone ?? this.userPhone,
      );

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
        userId: json["user_id"],
        firstName: json["first_name"],
        userLastName: json["user_last_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "user_last_name": userLastName,
        "user_email": userEmail,
        "user_phone": userPhone,
      };
}
