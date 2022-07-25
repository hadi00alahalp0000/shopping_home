

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/product_card.dart';
import 'package:shopping_home/screens/details/details_screen.dart';
import 'package:shopping_home/screens/home/components/section_title.dart';
import 'package:shopping_home/screens/home/home_screen.dart';

import '../../../controllers/view_controller.dart';
import '../../../size_config.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<AllProducts> createState() => AllProductsState();
}

class AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Column(children: [
      Row(
        children: [
          const SizedBox(width: 23),
          SectionTitle(
            text: "All Product".tr,
            press: () {},
          ),
        ],
      ),
      SizedBox(height: getProportionateScreenWidth(10)),
      Flexible(
          child: GridView.count(
        childAspectRatio: 0.65,
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        children: [
          ...List.generate(
            HomeScreen.controller.length,
            (index) => ProductCard(
              product: HomeScreen.controller[index],
              press: () async {
                ViewController controller = Get.put(ViewController());
                await controller.addView(HomeScreen.controller[index].id);
                Get.toNamed(
                  '/Details',
                  arguments: ProductDetailsArguments(
                    product: HomeScreen.controller[index],
                  ),
                );
              },
            ),
          ),
        ],
      )),
    ]);
  }
}
