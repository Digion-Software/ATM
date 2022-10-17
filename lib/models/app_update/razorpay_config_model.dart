import 'dart:convert';

RazorPayConfigModel razorPayConfigModeFromJson(String str) => RazorPayConfigModel.fromJson(json.decode(str));

String razorPayConfigModeToJson(RazorPayConfigModel data) => json.encode(data.toJson());

class RazorPayConfigModel {
  RazorPayConfigModel({
    required this.status,
    required this.data,
  });

  final String status;
  final Data data;

  RazorPayConfigModel copyWith({
    String? status,
    Data? data,
  }) =>
      RazorPayConfigModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory RazorPayConfigModel.fromJson(Map<String, dynamic> json) => RazorPayConfigModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.razorpayStatus,
    required this.razorpayData,
    required this.upiId,
    required this.upiQrcode,
  });

  final String razorpayStatus;
  final RazorpayData razorpayData;
  final String upiId;
  final String upiQrcode;

  Data copyWith({
    String? razorpayStatus,
    RazorpayData? razorpayData,
    String? upiId,
    String? upiQrcode,
  }) =>
      Data(
        razorpayStatus: razorpayStatus ?? this.razorpayStatus,
        razorpayData: razorpayData ?? this.razorpayData,
        upiId: upiId ?? this.upiId,
        upiQrcode: upiQrcode ?? this.upiQrcode,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    razorpayStatus: json["razorpay_status"],
    razorpayData: RazorpayData.fromJson(json["razorpay_data"]),
    upiId: json["UPI_ID"],
    upiQrcode: json["UPI_QRCODE"],
  );

  Map<String, dynamic> toJson() => {
    "razorpay_status": razorpayStatus,
    "razorpay_data": razorpayData.toJson(),
    "UPI_ID": upiId,
    "UPI_QRCODE": upiQrcode,
  };
}

class RazorpayData {
  RazorpayData({
    required this.key,
    required this.name,
    required this.description,
  });

  final String key;
  final String name;
  final String description;

  RazorpayData copyWith({
    String? key,
    String? name,
    String? description,
  }) =>
      RazorpayData(
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory RazorpayData.fromJson(Map<String, dynamic> json) => RazorpayData(
    key: json["key"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "description": description,
  };
}
