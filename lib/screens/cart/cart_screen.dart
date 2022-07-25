// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/show_my_order_controller.dart';
import 'package:shopping_home/models/my_order.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  //CartController controller = CartController();
  MyOrder cart = ShowMyOrderController.myOrder;
  static String routeName = "/Cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(
        cart: cart,
      ),
      bottomNavigationBar: CheckoutCard(
        cart: cart,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Column(
          children: [
            Text(
              "Your Cart".tr,
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              "${cart.orderProducts.length}" " items".tr,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
