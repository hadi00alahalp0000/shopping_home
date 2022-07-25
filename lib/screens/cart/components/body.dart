import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/delete_products_from_my_order_controller.dart';
import 'package:shopping_home/models/my_order.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final MyOrder cart;
  const Body({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  //CartController controller = CartController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount:
            widget.cart.orderProducts.length, //controller.cartproducts.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.cart.orderProducts[index].id.toString()),
            //key: Key(widget.cart.orderProducts[index].productId.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                // remove product from cart controller method
                DeleteProductsFromMyOrderController controller =
                    Get.put(DeleteProductsFromMyOrderController());
                controller.deleteProductFromMyOrder(
                    widget.cart.orderProducts[index].productId);
                widget.cart.orderProducts.removeAt(index);
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(
              cartproduct: widget.cart.orderProducts[index],
            ),
          ),
        ),
      ),
    );
  }
}
