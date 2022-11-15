// To parse this JSON data, do
//
//     final ticketListModel = ticketListModelFromJson(jsonString);

import 'dart:convert';

TicketListModel ticketListModelFromJson(String str) => TicketListModel.fromJson(json.decode(str));

String ticketListModelToJson(TicketListModel data) => json.encode(data.toJson());

class TicketListModel {
  TicketListModel({
    required this.status,
    required this.draw,
    required this.iTotalRecords,
    required this.iTotalDisplayRecords,
    required this.aaData,
  });

  final String? status;
  final int? draw;
  final int? iTotalRecords;
  final int? iTotalDisplayRecords;
  final List<AaDatum>? aaData;

  TicketListModel copyWith({
    String? status,
    int? draw,
    int? iTotalRecords,
    int? iTotalDisplayRecords,
    List<AaDatum>? aaData,
  }) =>
      TicketListModel(
        status: status ?? this.status,
        draw: draw ?? this.draw,
        iTotalRecords: iTotalRecords ?? this.iTotalRecords,
        iTotalDisplayRecords: iTotalDisplayRecords ?? this.iTotalDisplayRecords,
        aaData: aaData ?? this.aaData,
      );

  factory TicketListModel.fromJson(Map<String, dynamic> json) => TicketListModel(
        status: json["status"],
        draw: json["draw"],
        iTotalRecords: json["iTotalRecords"],
        iTotalDisplayRecords: json["iTotalDisplayRecords"],
        aaData: json["aaData"] == null ? null : List<AaDatum>.from(json["aaData"].map((x) => AaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "draw": draw,
        "iTotalRecords": iTotalRecords,
        "iTotalDisplayRecords": iTotalDisplayRecords,
        "aaData": aaData == null ? null : List<dynamic>.from(aaData!.map((x) => x.toJson())),
      };
}

class AaDatum {
  AaDatum({
    required this.srNo,
    required this.ticketId,
    required this.ticketChatId,
    required this.ticketTitle,
    required this.subject,
    required this.ticketBody,
    required this.status,
    required this.ticketDateTime,
  });

  final int? srNo;
  final String? ticketId;
  final String? ticketChatId;
  final String? ticketTitle;
  final String? subject;
  final String? ticketBody;
  final String? status;
  final String? ticketDateTime;

  AaDatum copyWith({
    int? srNo,
    String? ticketId,
    String? ticketChatId,
    String? ticketTitle,
    String? subject,
    String? ticketBody,
    String? status,
    String? ticketDateTime,
  }) =>
      AaDatum(
        srNo: srNo ?? this.srNo,
        ticketId: ticketId ?? this.ticketId,
        ticketChatId: ticketChatId ?? this.ticketChatId,
        ticketTitle: ticketTitle ?? this.ticketTitle,
        subject: subject ?? this.subject,
        ticketBody: ticketBody ?? this.ticketBody,
        status: status ?? this.status,
        ticketDateTime: ticketDateTime ?? this.ticketDateTime,
      );

  factory AaDatum.fromJson(Map<String, dynamic> json) => AaDatum(
        srNo: json["sr_no"],
        ticketId: json["ticketID"],
        ticketChatId: json["ticketChatID"],
        ticketTitle: json["ticketTitle"],
        subject: json["subject"],
        ticketBody: json["ticketBody"],
        status: json["status"],
        ticketDateTime: json["ticketDateTime"],
      );

  Map<String, dynamic> toJson() => {
        "sr_no": srNo,
        "ticketID": ticketId,
        "ticketChatID": ticketChatId,
        "ticketTitle": ticketTitle,
        "subject": subject,
        "ticketBody": ticketBody,
        "status": status,
        "ticketDateTime": ticketDateTime,
      };
}
