// To parse this JSON data, do
//
//     final createUserModel = createUserModelFromJson(jsonString);

import 'dart:convert';

CreateUserModel createUserModelFromJson(String str) => CreateUserModel.fromJson(json.decode(str));

String createUserModelToJson(CreateUserModel data) => json.encode(data.toJson());

class CreateUserModel {
  CreateUserModel({
    required this.status,
    required this.message,
    required this.appMessage,
  });

  final String? status;
  final String? message;
  final String? appMessage;

  CreateUserModel copyWith({
    String? status,
    String? message,
    String? appMessage,
  }) =>
      CreateUserModel(
        status: status ?? this.status,
        message: message ?? this.message,
        appMessage: appMessage ?? this.appMessage,
      );

  factory CreateUserModel.fromJson(Map<String, dynamic> json) => CreateUserModel(
        status: json["status"],
        message: json["message"],
        appMessage: json["app_message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "app_message": appMessage,
      };
}
