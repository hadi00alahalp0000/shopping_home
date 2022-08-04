// To parse this JSON data, do
//
//     final myNotification = myNotificationFromJson(jsonString);

import 'dart:convert';

List<MyNotification> myNotificationFromJson(String str) =>
    List<MyNotification>.from(
        json.decode(str).map((x) => MyNotification.fromJson(x)));

String myNotificationToJson(List<MyNotification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyNotification {
  MyNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.description,
    required this.url,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String body;
  String description;
  String url;
  int userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MyNotification.fromJson(Map<String, dynamic> json) => MyNotification(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        description: json["description"],
        url: json["url"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "description": description,
        "url": url,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
