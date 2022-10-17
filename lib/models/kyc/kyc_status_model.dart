// To parse this JSON data, do
//
//     final kycStatusModel = kycStatusModelFromJson(jsonString);

import 'dart:convert';

KycStatusModel kycStatusModelFromJson(String str) => KycStatusModel.fromJson(json.decode(str));

String kycStatusModelToJson(KycStatusModel data) => json.encode(data.toJson());

class KycStatusModel {
  KycStatusModel({
    required this.kycStatus,
    required this.kycData,
  });

  final String? kycStatus;
  final KycData? kycData;

  KycStatusModel copyWith({
    String? kycStatus,
    KycData? kycData,
  }) =>
      KycStatusModel(
        kycStatus: kycStatus ?? this.kycStatus,
        kycData: kycData ?? this.kycData,
      );

  factory KycStatusModel.fromJson(Map<String, dynamic> json) => KycStatusModel(
    kycStatus: json["kyc_status"],
    kycData: json["kyc_data"] == null ? null : KycData.fromJson(json["kyc_data"]),
  );

  Map<String, dynamic> toJson() => {
    "kyc_status": kycStatus,
    "kyc_data": kycData == null ? null : kycData!.toJson(),
  };
}

class KycData {
  KycData({
    required this.aadharCardFrontImage,
    required this.aadharCardBackImage,
    required this.pancardImage,
    required this.aadharCardNumber,
    required this.feedbackRemarks,
  });

  final String? aadharCardFrontImage;
  final String? aadharCardBackImage;
  final String? pancardImage;
  final dynamic aadharCardNumber;
  final String? feedbackRemarks;

  KycData copyWith({
    String? aadharCardFrontImage,
    String? aadharCardBackImage,
    String? pancardImage,
    dynamic aadharCardNumber,
    String? feedbackRemarks,
  }) =>
      KycData(
        aadharCardFrontImage: aadharCardFrontImage ?? this.aadharCardFrontImage,
        aadharCardBackImage: aadharCardBackImage ?? this.aadharCardBackImage,
        pancardImage: pancardImage ?? this.pancardImage,
        aadharCardNumber: aadharCardNumber ?? this.aadharCardNumber,
        feedbackRemarks: feedbackRemarks ?? this.feedbackRemarks,
      );

  factory KycData.fromJson(Map<String, dynamic> json) => KycData(
    aadharCardFrontImage: json["aadhar_card_front_image"],
    aadharCardBackImage: json["aadhar_card_back_image"],
    pancardImage: json["pancard_image"],
    aadharCardNumber: json["aadhar_card_number"],
    feedbackRemarks: json["feedback_remarks"],
  );

  Map<String, dynamic> toJson() => {
    "aadhar_card_front_image": aadharCardFrontImage,
    "aadhar_card_back_image": aadharCardBackImage,
    "pancard_image": pancardImage,
    "aadhar_card_number": aadharCardNumber,
    "feedback_remarks": feedbackRemarks,
  };
}
