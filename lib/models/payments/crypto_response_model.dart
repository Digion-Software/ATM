// To parse this JSON data, do
//
//     final cryptoResponseModel = cryptoResponseModelFromJson(jsonString);

import 'dart:convert';

CryptoResponseModel cryptoResponseModelFromJson(String str) => CryptoResponseModel.fromJson(json.decode(str));

String cryptoResponseModelToJson(CryptoResponseModel data) => json.encode(data.toJson());

class CryptoResponseModel {
  CryptoResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final CryptoData? data;

  CryptoResponseModel copyWith({
    String? status,
    String? message,
    CryptoData? data,
  }) =>
      CryptoResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CryptoResponseModel.fromJson(Map<String, dynamic> json) => CryptoResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : CryptoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class CryptoData {
  CryptoData({
    required this.investmentId,
    required this.cryptoAddress,
    required this.transactionId,
    required this.totalCryptoAmount,
    required this.totalCryptoRcvAmount,
    required this.timeout,
    required this.qrcodeUrl,
    required this.status,
  });

  final int investmentId;
  final String cryptoAddress;
  final String transactionId;
  final String totalCryptoAmount;
  final int totalCryptoRcvAmount;
  final int timeout;
  final String qrcodeUrl;
  final int status;

  CryptoData copyWith({
    int? investmentId,
    String? cryptoAddress,
    String? transactionId,
    String? totalCryptoAmount,
    int? totalCryptoRcvAmount,
    int? timeout,
    String? qrcodeUrl,
    int? status,
  }) =>
      CryptoData(
        investmentId: investmentId ?? this.investmentId,
        cryptoAddress: cryptoAddress ?? this.cryptoAddress,
        transactionId: transactionId ?? this.transactionId,
        totalCryptoAmount: totalCryptoAmount ?? this.totalCryptoAmount,
        totalCryptoRcvAmount: totalCryptoRcvAmount ?? this.totalCryptoRcvAmount,
        timeout: timeout ?? this.timeout,
        qrcodeUrl: qrcodeUrl ?? this.qrcodeUrl,
        status: status ?? this.status,
      );

  factory CryptoData.fromJson(Map<String, dynamic> json) => CryptoData(
        investmentId: json["investment_id"],
        cryptoAddress: json["crypto_address"],
        transactionId: json["transaction_id"],
        totalCryptoAmount: json["total_crypto_amount"],
        totalCryptoRcvAmount: json["total_crypto_rcv_amount"],
        timeout: json["timeout"],
        qrcodeUrl: json["qrcode_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "investment_id": investmentId,
        "crypto_address": cryptoAddress,
        "transaction_id": transactionId,
        "total_crypto_amount": totalCryptoAmount,
        "total_crypto_rcv_amount": totalCryptoRcvAmount,
        "timeout": timeout,
        "qrcode_url": qrcodeUrl,
        "status": status,
      };
}
