// ignore_for_file: non_constant_identifier_names, unnecessary_question_mark

class User {
  User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.birthdate,
    required this.governorate,
    required this.region,
    required this.street,
    this.contact_email,
    required this.phone_number,
    this.facebook_url,
    this.telegram_url,
    this.whatsapp,
    this.skype,
    this.createdAt,
    this.updatedAt,
  });
  int? id;
  String firstname;
  String lastname;
  String email;
  String password;
  dynamic birthdate;
  String governorate;
  String region;
  String? street;
  String? contact_email;
  String? phone_number;
  String? facebook_url;
  String? telegram_url;
  String? whatsapp;
  String? skype;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      birthdate: json['birthdate'],
      governorate: json['governorate'],
      region: json['region'],
      street: json['street'],
      contact_email: json['contact_email'],
      phone_number: json['phone_number'],
      facebook_url: json['facebook_url'],
      telegram_url: json['telegram_url'],
      whatsapp: json['whatsapp'],
      skype: json['skype'],
      // something: new List<String>.from(json['Categories']),
    );
  }
  
  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "birthdate": birthdate,
        "governorate": governorate,
        "region": region,
        "street": street,
        "contact_email": contact_email,
        "phone_number": phone_number,
        "facebook_url": facebook_url,
        "telegram_url": telegram_url,
        "whatsapp": whatsapp,
        "skype": skype,
      };
}

class EditPerson {
  EditPerson({
    this.id,
    this.firstname,
    this.lastname,
    this.password,
    this.birthdate,
    this.governorate,
    this.region,
    this.street,
    this.contact_email,
    this.phone_number,
    this.facebook_url,
    this.telegram_url,
    this.whatsapp,
    this.skype,
  });
  dynamic id;
  dynamic firstname;
  dynamic lastname;
  dynamic password;
  dynamic birthdate;
  dynamic governorate;
  dynamic region;
  dynamic street;
  dynamic contact_email;
  dynamic phone_number;
  dynamic? facebook_url;
  dynamic? telegram_url;
  dynamic? whatsapp;
  dynamic? skype;
  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "birthdate": birthdate,
        "governorate": governorate,
        "region": region,
        "street": street,
        "contact_email": contact_email,
        "phone_number": phone_number,
        "facebook_url": facebook_url,
        "telegram_url": telegram_url,
        "whatsapp": whatsapp,
        "skype": skype,
      };
}
