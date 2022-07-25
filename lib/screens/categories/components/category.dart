import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/models/show_products.dart';

import '../../../components/product_card.dart';
import '../../../controllers/view_controller.dart';
import '../../../models/category.dart';
import '../../details/details_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryArguments arguments =
        ModalRoute.of(context)!.settings.arguments as CategoryArguments;
    Category cate = arguments.cat;
    List<ShowProducts> prod = arguments.products;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(cate.name),
        ),
      ),
      body: GridView.count(
        childAspectRatio: 0.65,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        children: [
          ...List.generate(
            prod.length,
            (index) => ProductCard(
              product: prod[index],
              press: () async {
                ViewController controller = Get.put(ViewController());
                await controller.addView(prod[index].id);
                Get.toNamed(
                  '/Details',
                  arguments: ProductDetailsArguments(
                    product: prod[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryArguments {
  final Category cat;
  final List<ShowProducts> products;
  CategoryArguments({
    required this.cat,
    required this.products,
  });
}
