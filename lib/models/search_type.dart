// To parse this JSON data, do
//
//     final searchType = searchTypeFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, prefer_null_aware_operators, unnecessary_question_mark

import 'dart:convert';

SearchType searchTypeFromJson(String str) =>
    SearchType.fromJson(json.decode(str));

String searchTypeToJson(SearchType data) => json.encode(data.toJson());

class SearchType {
  SearchType({
    required this.productByName,
    required this.productByPrice,
    required this.productByCategoryName,
    required this.userByName,
  });

  List<ProductByYName> productByName;
  List<ProductByYName> productByPrice;
  List<ProductByYName> productByCategoryName;
  List<UserByName> userByName;

  factory SearchType.fromJson(Map<String, dynamic> json) => SearchType(
        productByName: List<ProductByYName>.from(
            json["Product by name"].map((x) => ProductByYName.fromJson(x))),
        productByPrice: List<ProductByYName>.from(
            json["Product by price"].map((x) => ProductByYName.fromJson(x))),
        productByCategoryName: List<ProductByYName>.from(
            json["Product by category name"]
                .map((x) => ProductByYName.fromJson(x))),
        userByName: List<UserByName>.from(
            json["User by name"].map((x) => UserByName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Product by name":
            List<dynamic>.from(productByName.map((x) => x.toJson())),
        "Product by price": List<dynamic>.from(productByPrice.map((x) => x)),
        "Product by category name":
            List<dynamic>.from(productByCategoryName.map((x) => x.toJson())),
        "User by name": List<dynamic>.from(userByName.map((x) => x.toJson())),
      };
}

class ProductByYName {
  ProductByYName({
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
    this.createdAt,
    this.updatedAt,
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
  ContactI contactId;
  CategoryId categoryId;
  int userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProductByYName.fromJson(Map<String, dynamic> json) => ProductByYName(
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
        contactId: ContactI.fromJson(json["contact_id"]),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ContactI {
  ContactI({
    required this.id,
    required this.contactEmail,
    required this.phoneNumber,
    required this.facebookUrl,
    required this.telegramUrl,
    required this.whatsapp,
    required this.skype,
    required this.twitter,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String contactEmail;
  String phoneNumber;
  String facebookUrl;
  String telegramUrl;
  String whatsapp;
  String skype;
  String twitter;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ContactI.fromJson(Map<String, dynamic> json) => ContactI(
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

class UserByName {
  UserByName({
    required this.user,
    required this.address,
    required this.contactInformations,
  });

  List<User> user;
  List<Address> address;
  List<ContactI> contactInformations;

  factory UserByName.fromJson(Map<String, dynamic> json) => UserByName(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        contactInformations: List<ContactI>.from(
            json["contact_informations"].map((x) => ContactI.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "contact_informations":
            List<dynamic>.from(contactInformations.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    required this.id,
    required this.governorate,
    required this.region,
    required this.street,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String governorate;
  String region;
  String street;
  dynamic? createdAt;
  dynamic? updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        governorate: json["governorate"],
        region: json["region"],
        street: json["street"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "governorate": governorate,
        "region": region,
        "street": street,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.emailVerifiedAt,
    required this.birthdate,
    required this.addressId,
    required this.contactId,
    this.profileImgUrl,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String firstname;
  String lastname;
  String email;
  dynamic emailVerifiedAt;
  DateTime birthdate;
  int addressId;
  int contactId;
  dynamic profileImgUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        birthdate: DateTime.parse(json["birthdate"]),
        addressId: json["address_id"],
        contactId: json["contact_id"],
        profileImgUrl: json["profile_img_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "address_id": addressId,
        "contact_id": contactId,
        "profile_img_url": profileImgUrl,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
