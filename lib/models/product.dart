// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    required this.name,
    this.img_url,
    required this.quantity,
    required this.price,
    required this.description,
    required this.category,
    required this.contact_email,
    required this.phone_number,
    required this.facebook_url,
    required this.telegram_url,
    required this.whatsapp,
    required this.skype,
    required this.twitter,
  });

  int? id;
  String name;
  String? img_url;
  int quantity;
  double price;
  String description;
  String category;
  String contact_email;
  String phone_number;
  String facebook_url;
  String telegram_url;
  String whatsapp;
  String skype;
  String twitter;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        img_url: json["img_url"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        contact_email: json["contact_email"],
        phone_number: json["phone_number"],
        facebook_url: json["facebook_url"],
        telegram_url: json["telegram_url"],
        whatsapp: json["whatsapp"],
        skype: json["skype"],
        twitter: json["twitter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img_url": img_url,
        "quantity": quantity,
        "price": price,
        "description": description,
        "category": category,
        "contact_email": contact_email,
        "phone_number": phone_number,
        "facebook_url": facebook_url,
        "telegram_url": telegram_url,
        "whatsapp": whatsapp,
        "skype": skype,
        "twitter": twitter,
      };
}

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

List<Product1> productFromJson1(String str) =>
    List<Product1>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson1(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product1 {
  Product1({
    this.id,
    this.name,
    this.img_url,
    this.quantity,
    this.price,
    this.description,
    this.num_star,
    this.num_reviews,
    this.num_views,
    this.num_likes,
    this.contact_id,
    this.category_id,
    this.user_id,
    this.created_at,
    this.updated_at,
  });

  int? id;
  String? name;
  dynamic img_url;
  int? quantity;
  double? price;
  String? description;
  int? num_star;
  int? num_reviews;
  int? num_views;
  int? num_likes;
  int? contact_id;
  int? category_id;
  int? user_id;
  DateTime? created_at;
  DateTime? updated_at;

  factory Product1.fromJson(Map<String, dynamic> json) => Product1(
        id: json["id"],
        name: json["name"],
        img_url: json["img_url"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        description: json["description"],
        num_star: json["num_star"],
        num_reviews: json["num_reviews"],
        num_views: json["num_views"],
        num_likes: json["num_likes"],
        contact_id: json["contact_id"],
        category_id: json["category_id"],
        user_id: json["user_id"],
        created_at: DateTime.parse(json["created_at"]),
        updated_at: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img_url": img_url,
        "quantity": quantity,
        "price": price,
        "description": description,
        "num_star": num_star,
        "num_reviews": num_reviews,
        "num_views": num_views,
        "num_likes": num_likes,
        "contact_id": contact_id,
        "category_id": category_id,
        "user_id": user_id,
        "created_at": created_at!.toIso8601String(),
        "updated_at": updated_at!.toIso8601String(),
      };
}
