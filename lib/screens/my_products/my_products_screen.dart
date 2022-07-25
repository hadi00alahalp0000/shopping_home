import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/controllers/view_controller.dart';
import 'package:shopping_home/models/show_products.dart';

import '../../../components/product_card.dart';

import '../details/details_screen.dart';

class MyProductsScreen extends StatelessWidget {
  //MyProductsController controller = Get.find();
  static List<ShowProducts> products = ShowProductsController.myProducts;
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("My Products".tr),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            press: () async {
              ViewController controller = Get.put(ViewController());
              await controller.addView(products[index].id);
              Get.toNamed(
                '/Details',
                arguments: ProductDetailsArguments(
                  product: products[index],
                ),
              );
            },
          );
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
