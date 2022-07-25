// To parse this JSON data, do
//
//     final myWallet = myWalletFromJson(jsonString);

import 'dart:convert';

MyWallet myWalletFromJson(String str) => MyWallet.fromJson(json.decode(str));

String myWalletToJson(MyWallet data) => json.encode(data.toJson());

class MyWallet {
  MyWallet({
    required this.id,
    required this.name,
    required this.description,
    required this.balance,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String description;
  int balance;
  int userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MyWallet.fromJson(Map<String, dynamic> json) => MyWallet(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        balance: json["Balance"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "Balance": balance,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
