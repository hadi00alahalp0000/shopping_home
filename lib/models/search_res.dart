// To parse this JSON data, do
//
//     final searchRes = searchResFromJson(jsonString);

import 'dart:convert';

List<dynamic> searchResFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => x));

String searchResToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

class SearchReElement {
  SearchReElement({
    required this.id,
    required this.productId,
    required this.date,
    required this.discountPercentage,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int productId;
  DateTime date;
  int discountPercentage;
  DateTime createdAt;
  DateTime updatedAt;

  factory SearchReElement.fromJson(Map<String, dynamic> json) =>
      SearchReElement(
        id: json["id"],
        productId: json["product_id"],
        date: DateTime.parse(json["date"]),
        discountPercentage: json["discount_percentage"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "discount_percentage": discountPercentage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PurpleSearchRe {
  PurpleSearchRe({
    required this.id,
    required this.name,
    required this.price,
    required this.currentPrice,
    required this.description,
    required this.expDate,
    required this.imgUrl,
    required this.quantity,
    required this.categoryId,
    required this.userId,
    required this.numLike,
    required this.numComment,
    required this.views,
    required this.numberPhone,
    required this.urlAccount,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int price;
  double currentPrice;
  String description;
  DateTime expDate;
  String imgUrl;
  int quantity;
  int categoryId;
  int userId;
  int numLike;
  int numComment;
  int views;
  String numberPhone;
  String urlAccount;
  DateTime createdAt;
  DateTime updatedAt;

  factory PurpleSearchRe.fromJson(Map<String, dynamic> json) => PurpleSearchRe(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        currentPrice: json["current_price"].toDouble(),
        description: json["description"],
        expDate: DateTime.parse(json["exp_date"]),
        imgUrl: json["img_url"],
        quantity: json["quantity"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        numLike: json["num_like"],
        numComment: json["num_comment"],
        views: json["views"],
        numberPhone: json["number_phone"],
        // ignore: prefer_if_null_operators
        urlAccount: json["url_account"] == null ? null : json["url_account"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "current_price": currentPrice,
        "description": description,
        "exp_date":
            "${expDate.year.toString().padLeft(4, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.day.toString().padLeft(2, '0')}",
        "img_url": imgUrl,
        "quantity": quantity,
        "category_id": categoryId,
        "user_id": userId,
        "num_like": numLike,
        "num_comment": numComment,
        "views": views,
        "number_phone": numberPhone,
        // ignore: unnecessary_null_comparison, prefer_if_null_operators
        "url_account": urlAccount == null ? null : urlAccount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
