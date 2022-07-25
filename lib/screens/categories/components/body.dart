import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/screens/categories/categories_screen.dart';
import 'package:shopping_home/size_config.dart';

import 'category.dart';
import 'category_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(5),
        ),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(15)),
            Center(
              child: Text(
                "All Categories".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                children: [
                  ...List.generate(
                    CategoriesScreen.categories.length,
                    (index) => CategoryCard(
                      catIndex: index,
                      text: CategoriesScreen.categories[index].name,
                      press: () async {
                        // Wating the Controller to get All Products That inside this Category
                        ShowProductsController controller =
                            Get.put(ShowProductsController());
                        await controller.getProducts(
                          ConstServer.showAllProductsByCategoryId,
                          'nothing',
                          CategoriesScreen.categories[index].id,
                        );
                        // Go to category with products inside it
                        Get.toNamed(
                          "/Category",
                          arguments: CategoryArguments(
                            cat: CategoriesScreen.categories[index],
                            products: ShowProductsController.productsByCategoryId,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
