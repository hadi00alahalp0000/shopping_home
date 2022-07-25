import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shopping_home/models/show_products.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductSearchCard extends StatelessWidget {
  const ProductSearchCard({
    Key? key,
    this.width = 100,
    this.aspectRetion = 1.02,
    required this.product,
    required this.press,
  }) : super(key: key);

  final double width, aspectRetion;
  final ShowProducts product;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    //PurpleProduct product = PurpleProduct.fromJson(prod[]);
    //List<ProductElement> productDiscounts = prod[1];
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRetion,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Expanded(
                    child: Image.asset(
                      "",
                      // product.imgUrl,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              AutoSizeText(
                product.name,
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLines: 2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        width: getProportionateScreenWidth(25),
                        height: getProportionateScreenWidth(25),
                        // decoration: BoxDecoration(
                        //   color: product.isFavourite
                        //       ? kPrimaryColor.withOpacity(0.15)
                        //       : kSecondaryColor.withOpacity(0.1),
                        //   shape: BoxShape.circle,
                        // ),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          color: const Color(0xFFFF4848),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "${product.numLikes}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenWidth(30),
                        // decoration: BoxDecoration(
                        //   color: product.isFavourite
                        //       ? kPrimaryColor.withOpacity(0.15)
                        //       : kSecondaryColor.withOpacity(0.1),
                        //   shape: BoxShape.circle,
                        // ),
                        child: SvgPicture.asset(
                          "assets/icons/icons8-view-64.svg",
                          fit: BoxFit.cover,
                          color: const Color(0xFFFF4848),
                        ),
                      ),
                      Text(
                        "${product.numViews}",
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Expiry Date:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        '',
                        //" " + DateFormat('yyyy/MM/dd').format(product.expDate),
                        style: TextStyle(color: kPrimaryColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
