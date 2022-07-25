import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/buy_my_order_controller.dart';
import 'package:shopping_home/models/my_order.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  final MyOrder cart;
  const CheckoutCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n".tr,
                    children: [
                      TextSpan(
                        text: "\$${cart.order.payment.currentTotalPrice}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out".tr,
                    press: () {
                      BuyMyOrderController controller =
                          Get.put(BuyMyOrderController());
                      controller.buyMyOrder();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
