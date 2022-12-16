// To parse this JSON data, do
//
//     final cryptoMethodsModel = cryptoMethodsModelFromJson(jsonString);

import 'dart:convert';

CryptoMethodsModel cryptoMethodsModelFromJson(String str) => CryptoMethodsModel.fromJson(json.decode(str));

String cryptoMethodsModelToJson(CryptoMethodsModel data) => json.encode(data.toJson());

class CryptoMethodsModel {
  CryptoMethodsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<Datum> data;

  CryptoMethodsModel copyWith({
    String? status,
    String? message,
    List<Datum>? data,
  }) =>
      CryptoMethodsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CryptoMethodsModel.fromJson(Map<String, dynamic> json) => CryptoMethodsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == [] ? null : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({required this.title, required this.imageUrl, required this.status, required this.upiId, required this.qrCode});

  final String title;
  final String imageUrl;
  final int status;
  final String upiId;
  final String qrCode;

  Datum copyWith({
    String? title,
    String? imageUrl,
    int? status,
    String? upiId,
    String? qrCode,
  }) =>
      Datum(
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        status: status ?? this.status,
        upiId: upiId ?? this.upiId,
        qrCode: qrCode ?? this.qrCode,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        imageUrl: json["image_url"],
        status: json["status"],
        upiId: json["upi_id"].toString(),
        qrCode: json["qr_code"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image_url": imageUrl,
        "status": status,
        "upi_id": upiId,
        "qr_code": qrCode,
      };
}
