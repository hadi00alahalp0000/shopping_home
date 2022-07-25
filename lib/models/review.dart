// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    this.id,
    required this.review,
    required this.numStar,
    this.loginId,
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String review;
  int numStar;
  int? loginId;
  int? userId;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        review: json["review"],
        numStar: json["num_star"],
        loginId: json["login_id"],
        userId: json["user_id"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "num_star": numStar,
        "login_id": loginId,
        "user_id": userId,
        "product_id": productId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
