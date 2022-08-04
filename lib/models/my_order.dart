// To parse this JSON data, do
//
//     final myOrder = myOrderFromJson(jsonString);

import 'dart:convert';

MyOrder myOrderFromJson(String str) => MyOrder.fromJson(json.decode(str));

String myOrderToJson(MyOrder data) => json.encode(data.toJson());

class MyOrder {
  MyOrder({
    required this.order,
    required this.orderProducts,
  });

  Order order;
  List<OrderProduct> orderProducts;

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        order: Order.fromJson(json["order"]),
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "order_products":
            List<dynamic>.from(orderProducts.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    required this.id,
    required this.name,
    required this.description,
    required this.isSold,
    required this.receiveAddressId,
    required this.paymentId,
    required this.userId,
    required this.loginId,
    this.createdAt,
    this.updatedAt,
    required this.payment,
  });

  int id;
  String name;
  String description;
  int isSold;
  int receiveAddressId;
  int paymentId;
  int userId;
  int loginId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Payment payment;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isSold: json["is_sold"],
        receiveAddressId: json["receive_address_id"],
        paymentId: json["payment_id"],
        userId: json["user_id"],
        loginId: json["login_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        payment: Payment.fromJson(json["payment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_sold": isSold,
        "receive_address_id": receiveAddressId,
        "payment_id": paymentId,
        "user_id": userId,
        "login_id": loginId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "payment": payment.toJson(),
      };
}

class Payment {
  Payment({
    required this.id,
    required this.name,
    required this.currentTotalPrice,
    required this.payId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int currentTotalPrice;
  int payId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        name: json["name"],
        currentTotalPrice: json["current_total_price"],
        payId: json["pay_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "current_total_price": currentTotalPrice,
        "pay_id": payId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class OrderProduct {
  OrderProduct({
    required this.id,
    required this.quantity,
    required this.orderId,
    required this.productId,
    this.createdAt,
    this.updatedAt,
    required this.product,
  });

  int id;
  int quantity;
  int orderId;
  int productId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product product;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        quantity: json["quantity"],
        orderId: json["order_id"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "order_id": orderId,
        "product_id": productId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "product": product.toJson(),
      };
}

class Product {
  Product({
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
  double price;
  String description;
  int numStar;
  int numReviews;
  int numViews;
  int numLikes;
  ContactId contactId;
  CategoryId categoryId;
  int userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imgUrl: json["img_url"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
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

class ContactId {
  ContactId({
    required this.id,
    required this.contactEmail,
    required this.phoneNumber,
    required this.facebookUrl,
    required this.telegramUrl,
    required this.whatsapp,
    required this.skype,
    this.twitter,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String contactEmail;
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
