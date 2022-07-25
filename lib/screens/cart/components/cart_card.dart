// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/models/my_order.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cartproduct,
  }) : super(key: key);

  final OrderProduct cartproduct; // final CartProduct cartproduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              // because its network image want the domain name
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                    ConstServer.domaiNname + '/' + cartproduct.product.imgUrl),
              ),
                  
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartproduct.product.name,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cartproduct.product.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cartproduct.quantity}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
