import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.status,
    required this.transactionData,
  });

  final String? status;
  final List<TransactionDatum>? transactionData;

  TransactionModel copyWith({
    String? status,
    List<TransactionDatum>? transactionData,
  }) =>
      TransactionModel(
        status: status ?? this.status,
        transactionData: transactionData ?? this.transactionData,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        status: json["status"],
        transactionData: json["transaction_data"] == null
            ? null
            : List<TransactionDatum>.from(json["transaction_data"].map((x) => TransactionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "transaction_data":
            transactionData == null ? null : List<dynamic>.from(transactionData!.map((x) => x.toJson())),
      };
}

class TransactionDatum {
  TransactionDatum({
    required this.id,
    required this.transactionId,
    required this.amount,
    required this.planName,
    required this.remarks,
    required this.addedDatetime,
  });

  final String? id;
  final String? transactionId;
  final String? amount;
  final String? planName;
  final String? remarks;
  final String? addedDatetime;

  TransactionDatum copyWith({
    String? id,
    String? transactionId,
    String? amount,
    String? planName,
    String? remarks,
    String? addedDatetime,
  }) =>
      TransactionDatum(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        amount: amount ?? this.amount,
        planName: planName ?? this.planName,
        remarks: remarks ?? this.remarks,
        addedDatetime: addedDatetime ?? this.addedDatetime,
      );

  factory TransactionDatum.fromJson(Map<String, dynamic> json) => TransactionDatum(
        id: json["id"],
        transactionId: json["transaction_id"],
        amount: json["amount"],
        planName: json["plan_name"],
        remarks: json["remarks"],
        addedDatetime: json["added_datetime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "amount": amount,
        "plan_name": planName,
        "remarks": remarks,
        "added_datetime": addedDatetime,
      };
}
