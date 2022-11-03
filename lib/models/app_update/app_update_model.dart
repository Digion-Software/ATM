
import 'dart:convert';

AppUpdateModel appUpdateModelFromJson(String str) => AppUpdateModel.fromJson(json.decode(str));

String appUpdateModelToJson(AppUpdateModel data) => json.encode(data.toJson());

class AppUpdateModel {
  AppUpdateModel({
    required this.status,
    required this.data,
  });

  final String status;
  final Data data;

  AppUpdateModel copyWith({
    String? status,
    Data? data,
  }) =>
      AppUpdateModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) => AppUpdateModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data":  data.toJson(),
  };
}

class Data {
  Data({
    required this.androidForceUpdate,
    required this.iosForceUpdate,
    required this.androidUrl,
    required this.androidVersion,
    required this.iosUrl,
    required this.iosVersion,
    required this.paymentMethod
  });

  final bool androidForceUpdate;
  final bool iosForceUpdate;
  final String androidUrl;
  final String androidVersion;
  final String iosUrl;
  final String iosVersion;
  final String paymentMethod;

  Data copyWith({
    bool? androidForceUpdate,
    bool? iosForceUpdate,
    String? androidUrl,
    String? androidVersion,
    String? iosUrl,
    String? iosVersion,
    String? paymentMethod,
  }) =>
      Data(
        androidForceUpdate: androidForceUpdate ?? this.androidForceUpdate,
        iosForceUpdate: iosForceUpdate ?? this.iosForceUpdate,
        androidUrl: androidUrl ?? this.androidUrl,
        androidVersion: androidVersion ?? this.androidVersion,
        iosUrl: iosUrl ?? this.iosUrl,
        iosVersion: iosVersion ?? this.iosVersion,
        paymentMethod: paymentMethod ?? this.paymentMethod
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    androidForceUpdate: json["android_force_update"],
    iosForceUpdate: json["ios_force_update"],
    androidUrl: json["android_url"],
    androidVersion: json["android_version"],
    iosUrl: json["ios_url"],
    iosVersion: json["ios_version"],
    paymentMethod: json["paymentMethod"]
  );

  Map<String, dynamic> toJson() => {
    "android_force_update": androidForceUpdate,
    "ios_force_update": iosForceUpdate,
    "android_url": androidUrl,
    "android_version": androidVersion,
    "ios_url": iosUrl,
    "ios_version": iosVersion,
    "paymentMethod":paymentMethod
  };
}
