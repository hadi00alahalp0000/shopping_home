import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/show_my_order_controller.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () {
              // Go To My Cart
              ShowMyOrderController controller =
                  Get.put(ShowMyOrderController());
              controller.getMyOrder();
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfItems: 3, // number of unreaded notifications
            press: () => Get.toNamed("/Notifications"),
          ),
        ],
      ),
    );
  }
}
