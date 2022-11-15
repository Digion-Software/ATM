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
    required this.conversation,
  });

  final String? tickettitle;
  final String? subject;
  final String? ticketbody;
  final String? ticketstatus;
  final List<Conversation>? conversation;

  Datum copyWith({
    String? tickettitle,
    String? subject,
    String? ticketbody,
    String? ticketstatus,
    List<Conversation>? conversation,
  }) =>
      Datum(
        tickettitle: tickettitle ?? this.tickettitle,
        subject: subject ?? this.subject,
        ticketbody: ticketbody ?? this.ticketbody,
        ticketstatus: ticketstatus ?? this.ticketstatus,
        conversation: conversation ?? this.conversation,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        tickettitle: json["tickettitle"],
        subject: json["subject"],
        ticketbody: json["ticketbody"],
        ticketstatus: json["ticketstatus"],
        conversation: json["conversation"] == null
            ? null
            : List<Conversation>.from(json["conversation"].map((x) => Conversation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tickettitle": tickettitle,
        "subject": subject,
        "ticketbody": ticketbody,
        "ticketstatus": ticketstatus,
        "conversation": conversation == null ? null : List<dynamic>.from(conversation!.map((x) => x.toJson())),
      };
}

class Conversation {
  Conversation({
    required this.receiverid,
    required this.senderid,
    required this.senderName,
    required this.ticketconversation,
    required this.avtar,
    required this.position,
    required this.attachment,
  });

  final String? receiverid;
  final String? senderid;
  final String? senderName;
  final String? ticketconversation;
  final String? avtar;
  final String? position;
  final String? attachment;

  Conversation copyWith({
    String? receiverid,
    String? senderid,
    String? senderName,
    String? ticketconversation,
    String? avtar,
    String? position,
    String? attachment,
  }) =>
      Conversation(
        receiverid: receiverid ?? this.receiverid,
        senderid: senderid ?? this.senderid,
        senderName: senderName ?? this.senderName,
        ticketconversation: ticketconversation ?? this.ticketconversation,
        avtar: avtar ?? this.avtar,
        position: position ?? this.position,
        attachment: attachment ?? this.attachment,
      );

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        receiverid: json["receiverid"],
        senderid: json["senderid"],
        senderName: json["sender_name"],
        ticketconversation: json["ticketconversation"],
        avtar: json["avtar"],
        position: json["position"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "receiverid": receiverid,
        "senderid": senderid,
        "sender_name": senderName,
        "ticketconversation": ticketconversation,
        "avtar": avtar,
        "position": position,
        "attachment": attachment,
      };
}
