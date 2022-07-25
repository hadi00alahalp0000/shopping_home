// To parse this JSON data, do
//
//     final payRecordDetails = payRecordDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:shopping_home/models/my_profile.dart';

List<PayRecordDetails> payRecordDetailsFromJson(String str) =>
    List<PayRecordDetails>.from(
        json.decode(str).map((x) => PayRecordDetails.fromJson(x)));

String payRecordDetailsToJson(List<PayRecordDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayRecordDetails {
  PayRecordDetails({
    required this.id,
    required this.balance,
    required this.payId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  int balance;
  int payId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  MyProfile user;
  //OrderDetailUser user;

  factory PayRecordDetails.fromJson(Map<String, dynamic> json) =>
      PayRecordDetails(
        id: json["id"],
        balance: json["balance"],
        payId: json["pay_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: MyProfile.fromJson(json["user"]),
        //user: OrderDetailUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "pay_id": payId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class OrderDetailUser {
  OrderDetailUser({
    required this.user,
    required this.address,
    required this.contactInformations,
  });

  List<UserElement> user;
  List<Address> address;
  List<ContactInformation> contactInformations;

  factory OrderDetailUser.fromJson(Map<String, dynamic> json) =>
      OrderDetailUser(
        user: List<UserElement>.from(
            json["user"].map((x) => UserElement.fromJson(x))),
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
  dynamic createdAt;
  dynamic updatedAt;

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

class ContactInformation {
  ContactInformation({
    required this.id,
    required this.contactEmail,
    required this.phoneNumber,
    this.facebookUrl,
    this.telegramUrl,
    this.whatsapp,
    this.skype,
    this.twitter,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  dynamic contactEmail;
  String phoneNumber;
  dynamic facebookUrl;
  dynamic telegramUrl;
  dynamic whatsapp;
  dynamic skype;
  dynamic twitter;
  dynamic createdAt;
  dynamic updatedAt;

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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UserElement {
  UserElement({
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

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
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
