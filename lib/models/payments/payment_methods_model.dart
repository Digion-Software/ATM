// To parse this JSON data, do
//
//     final paymentMethodsModel = paymentMethodsModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodsModel paymentMethodsModelFromJson(String str) => PaymentMethodsModel.fromJson(json.decode(str));

String paymentMethodsModelToJson(PaymentMethodsModel data) => json.encode(data.toJson());

class PaymentMethodsModel {
  PaymentMethodsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<PaymentMethodDatum> data;

  PaymentMethodsModel copyWith({
    String? status,
    String? message,
    List<PaymentMethodDatum>? data,
  }) =>
      PaymentMethodsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) => PaymentMethodsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<PaymentMethodDatum>.from(json["data"].map((x) => PaymentMethodDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == [] ? null : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PaymentMethodDatum {
  PaymentMethodDatum({
    required this.title,
    required this.slug,
    required this.imageUrl,
    required this.status,
    required this.qrCode,
    required this.upiId,
  });

  final String title;
  final String slug;
  final String imageUrl;
  final int status;
  final String qrCode;
  final String upiId;

  PaymentMethodDatum copyWith({
    String? title,
    String? slug,
    String? imageUrl,
    int? status,
    String? qrCode,
    String? upiId,
  }) =>
      PaymentMethodDatum(
        title: title ?? this.title,
        slug: slug ?? this.slug,
        imageUrl: imageUrl ?? this.imageUrl,
        status: status ?? this.status,
        qrCode: qrCode ?? this.qrCode,
        upiId: upiId ?? this.upiId,
      );

  factory PaymentMethodDatum.fromJson(Map<String, dynamic> json) => PaymentMethodDatum(
        title: json["title"],
        slug: json["slug"],
        imageUrl: json["image_url"],
        status: json["status"],
        qrCode: json["qr_code"],
        upiId: json["upi_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "image_url": imageUrl,
        "status": status,
        "qr_code": qrCode,
        "upi_id": upiId,
      };
}
