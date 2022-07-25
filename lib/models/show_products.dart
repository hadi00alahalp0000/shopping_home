// To parse this JSON data, do
//
//     final showProducts = showProductsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators, unnecessary_null_comparison

import 'dart:convert';

List<ShowProducts> showProductsFromJson(String str) => List<ShowProducts>.from(
    json.decode(str).map((x) => ShowProducts.fromJson(x)));

String showProductsToJson(List<ShowProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowProducts {
  ShowProducts({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.quantity,
    required this.price,
    required this.description,
    required this.numStar,
    required this.numReviews,
    required this.numViews,
    required this.numLikes,
    required this.contactId,
    required this.categoryId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  dynamic imgUrl;
  int quantity;
  int price;
  String description;
  int numStar;
  int numReviews;
  int numViews;
  int numLikes;
  ContactId contactId;
  CategoryId categoryId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory ShowProducts.fromJson(Map<String, dynamic> json) => ShowProducts(
        id: json["id"],
        name: json["name"],
        imgUrl: json["img_url"],
        quantity: json["quantity"],
        price: json["price"],
        description: json["description"],
        numStar: json["num_star"],
        numReviews: json["num_reviews"],
        numViews: json["num_views"],
        numLikes: json["num_likes"],
        contactId: ContactId.fromJson(json["contact_id"]),
        categoryId: CategoryId.fromJson(json["category_id"]),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img_url": imgUrl,
        "quantity": quantity,
        "price": price,
        "description": description,
        "num_star": numStar,
        "num_reviews": numReviews,
        "num_views": numViews,
        "num_likes": numLikes,
        "contact_id": contactId.toJson(),
        "category_id": categoryId.toJson(),
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ContactId {
  ContactId({
    required this.id,
    required this.contactEmail,
    required this.phoneNumber,
    required this.facebookUrl,
    required this.telegramUrl,
    required this.whatsapp,
    required this.skype,
    required this.twitter,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? contactEmail;
  String phoneNumber;
  String? facebookUrl;
  String? telegramUrl;
  String? whatsapp;
  String? skype;
  String? twitter;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ContactId.fromJson(Map<String, dynamic> json) => ContactId(
        id: json["id"],
        contactEmail:
            json["contact_email"] == null ? null : json["contact_email"],
        phoneNumber: json["phone_number"],
        facebookUrl: json["facebook_url"] == null ? null : json["facebook_url"],
        telegramUrl: json["telegram_url"] == null ? null : json["telegram_url"],
        whatsapp: json["whatsapp"] == null ? null : json["whatsapp"],
        skype: json["skype"] == null ? null : json["skype"],
        twitter: json["twitter"] == null ? null : json["twitter"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_email": contactEmail == null ? null : contactEmail,
        "phone_number": phoneNumber,
        "facebook_url": facebookUrl == null ? null : facebookUrl,
        "telegram_url": telegramUrl == null ? null : telegramUrl,
        "whatsapp": whatsapp == null ? null : whatsapp,
        "skype": skype == null ? null : skype,
        "twitter": twitter == null ? null : twitter,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
