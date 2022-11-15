// To parse this JSON data, do
//
//     final viewTicketChatModel = viewTicketChatModelFromJson(jsonString);

import 'dart:convert';

ViewTicketChatModel viewTicketChatModelFromJson(String str) => ViewTicketChatModel.fromJson(json.decode(str));

String viewTicketChatModelToJson(ViewTicketChatModel data) => json.encode(data.toJson());

class ViewTicketChatModel {
  ViewTicketChatModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<Datum>? data;

  ViewTicketChatModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      ViewTicketChatModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ViewTicketChatModel.fromJson(Map<String, dynamic> json) => ViewTicketChatModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.tickettitle,
    required this.subject,
    required this.ticketbody,
    required this.ticketstatus,
  });

  final String? tickettitle;
  final String? subject;
  final String? ticketbody;
  final String? ticketstatus;

  Datum copyWith({
    String? tickettitle,
    String? subject,
    String? ticketbody,
    String? ticketstatus,
  }) =>
      Datum(
        tickettitle: tickettitle ?? this.tickettitle,
        subject: subject ?? this.subject,
        ticketbody: ticketbody ?? this.ticketbody,
        ticketstatus: ticketstatus ?? this.ticketstatus,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        tickettitle: json["tickettitle"],
        subject: json["subject"],
        ticketbody: json["ticketbody"],
        ticketstatus: json["ticketstatus"],
      );

  Map<String, dynamic> toJson() => {
        "tickettitle": tickettitle,
        "subject": subject,
        "ticketbody": ticketbody,
        "ticketstatus": ticketstatus,
      };
}
