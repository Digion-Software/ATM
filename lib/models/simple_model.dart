// To parse this JSON data, do
//
//     final simpleModel = simpleModelFromJson(jsonString);

import 'dart:convert';

SimpleModel simpleModelFromJson(String str) => SimpleModel.fromJson(json.decode(str));

String simpleModelToJson(SimpleModel data) => json.encode(data.toJson());

class SimpleModel {
  SimpleModel({
    required this.status,
    required this.message,
  });

  final String status;
  final String message;

  SimpleModel copyWith({
    String? status,
    String? message,
  }) =>
      SimpleModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory SimpleModel.fromJson(Map<String, dynamic> json) => SimpleModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
