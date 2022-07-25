// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shopping_home/const_server.dart';

import '../constants.dart';
import '../models/show_products.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
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
    // PurpleProduct product = PurpleProduct.fromJson(prod[0]);
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
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: product.imgUrl == null
                          ? Image.asset('assets/images/big_logo.png').image
                          : Image.network(
                                  '${ConstServer.domaiNname}/' + product.imgUrl)
                              .image, // || product.imgUrl is String ? Image.asset("assets/images/big_logo.png").image : product.imgUrl
                      //HomeScreen.control.images[product.id]
                      //.image, //add widget. before product
                    ),
                  ),
                ),
              ),
              AutoSizeText(
                product.name, //add widget. before product
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
                    "\$${product.price}", //add widget. before product
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
                          "${product.numLikes}", //add widget. before product
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
                        "${product.numViews}", //add widget. before product
                        style: const TextStyle(color: Colors.black),
                      )
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
