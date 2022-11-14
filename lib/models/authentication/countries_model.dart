// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CountriesModel countriesModelFromJson(String str) => CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  CountriesModel({
    required this.status,
    required this.data,
    required this.userCountry,
  });

  final String status;
  final List<Datum> data;
  final String userCountry;

  CountriesModel copyWith({
    String? status,
    List<Datum>? data,
    String? userCountry,
  }) =>
      CountriesModel(
        status: status ?? this.status,
        data: data ?? this.data,
        userCountry: userCountry ?? this.userCountry,
      );

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    userCountry: json["user_country"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == [] ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
    "user_country": userCountry,
  };
}

class Datum {
  Datum({
    required this.srNo,
    required this.id,
    required this.iso,
    required this.name,
    required this.nicename,
    required this.iso3,
    required this.numcode,
    required this.flag,
    required this.phonecode,
  });

  final int srNo;
  final String id;
  final String iso;
  final String name;
  final String nicename;
  final String iso3;
  final String numcode;
  final String flag;
  final String phonecode;

  Datum copyWith({
    int? srNo,
    String? id,
    String? iso,
    String? name,
    String? nicename,
    String? iso3,
    String? numcode,
    String? flag,
    String? phonecode,
  }) =>
      Datum(
        srNo: srNo ?? this.srNo,
        id: id ?? this.id,
        iso: iso ?? this.iso,
        name: name ?? this.name,
        nicename: nicename ?? this.nicename,
        iso3: iso3 ?? this.iso3,
        numcode: numcode ?? this.numcode,
        flag: flag ?? this.flag,
        phonecode: phonecode ?? this.phonecode,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    srNo: int.parse(json["sr_no"].toString()),
    id: json["id"].toString(),
    iso: json["iso"].toString(),
    name: json["name"].toString(),
    nicename: json["nicename"].toString(),
    iso3: json["iso3"].toString(),
    numcode: json["numcode"].toString(),
    flag: json["flag"].toString(),
    phonecode: json["phonecode"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "sr_no": srNo,
    "id": id,
    "iso": iso,
    "name": name,
    "nicename": nicename,
    "iso3": iso3,
    "numcode": numcode,
    "flag": flag,
    "phonecode": phonecode,
  };
}
