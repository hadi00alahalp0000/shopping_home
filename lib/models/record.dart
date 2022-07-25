// To parse this JSON data, do
//
//     final record = recordFromJson(jsonString);

import 'dart:convert';

List<Record> recordFromJson(String str) =>
    List<Record>.from(json.decode(str).map((x) => Record.fromJson(x)));

String recordToJson(List<Record> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Record {
  Record({
    required this.id,
    required this.balance,
    required this.walletId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int balance;
  int walletId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        balance: json["balance"],
        walletId: json["wallet_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "wallet_id": walletId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
