// To parse this JSON data, do
//
//     final ticketOptionModel = ticketOptionModelFromJson(jsonString);

import 'dart:convert';

TicketOptionModel ticketOptionModelFromJson(String str) => TicketOptionModel.fromJson(json.decode(str));

String ticketOptionModelToJson(TicketOptionModel data) => json.encode(data.toJson());

class TicketOptionModel {
  TicketOptionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<String>? data;

  TicketOptionModel copyWith({
    String? status,
    String? message,
    List<String>? data,
  }) =>
      TicketOptionModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory TicketOptionModel.fromJson(Map<String, dynamic> json) => TicketOptionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
      };
}
