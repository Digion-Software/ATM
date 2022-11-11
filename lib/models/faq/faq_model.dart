// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final List<Datum>? data;

  FaqModel copyWith({
    String? status,
    List<Datum>? data,
  }) =>
      FaqModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    status: json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.faqId,
    required this.question,
    required this.answer,
  });

  final String? faqId;
  final String? question;
  final String? answer;

  Datum copyWith({
    String? faqId,
    String? question,
    String? answer,
  }) =>
      Datum(
        faqId: faqId ?? this.faqId,
        question: question ?? this.question,
        answer: answer ?? this.answer,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    faqId: json["faq_id"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "faq_id": faqId,
    "question": question,
    "answer": answer,
  };
}
