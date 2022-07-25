// To parse this JSON data, do
//
//     final myProfile = myProfileFromJson(jsonString);

import 'dart:convert';

// List<dynamic> userFromJson(String str) => List<dynamic>.from(
//     json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

List<MyProfile> allUsersFromJson(String str) =>
    List<MyProfile>.from(json.decode(str).map((x) => MyProfile.fromJson(x)));

MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));

String myProfileToJson(MyProfile data) => json.encode(data.toJson());

class MyProfile {
  MyProfile({
    required this.user,
    required this.address,
    required this.contactInformations,
  });

  List<User> user;
  List<Address> address;
  List<ContactInformation> contactInformations;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        contactInformations: List<ContactInformation>.from(
            json["contact_informations"]
                .map((x) => ContactInformation.fromJson(x))),
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
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        governorate: json["governorate"],
        region: json["region"],
        street: json["street"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "governorate": governorate,
        "region": region,
        "street": street,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ContactInformation {
  ContactInformation({
    required this.id,
    this.contactEmail,
    this.phoneNumber,
    this.facebookUrl,
    this.telegramUrl,
    this.whatsapp,
    this.skype,
    this.twitter,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? contactEmail;
  String? phoneNumber;
  String? facebookUrl;
  String? telegramUrl;
  String? whatsapp;
  String? skype;
  dynamic twitter;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ContactInformation.fromJson(Map<String, dynamic> json) =>
      ContactInformation(
        id: json["id"],
        contactEmail: json["contact_email"],
        phoneNumber: json["phone_number"],
        facebookUrl: json["facebook_url"],
        telegramUrl: json["telegram_url"],
        whatsapp: json["whatsapp"],
        skype: json["skype"],
        twitter: json["twitter"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_email": contactEmail,
        "phone_number": phoneNumber,
        "facebook_url": facebookUrl,
        "telegram_url": telegramUrl,
        "whatsapp": whatsapp,
        "skype": skype,
        "twitter": twitter,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class User {
  User({
    this.id,
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

  int? id;
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
