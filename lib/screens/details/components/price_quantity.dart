import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../models/show_products.dart';
import '../../../size_config.dart';

class PriceQuantity extends StatefulWidget {
  const PriceQuantity({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ShowProducts product;

  @override
  State<PriceQuantity> createState() => _PriceQuantityState();
}

class _PriceQuantityState extends State<PriceQuantity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity : ".tr + widget.product.quantity.toString(),
                style: TextStyle(fontSize: getProportionateScreenHeight(20)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
