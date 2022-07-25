import 'package:flutter/material.dart';
import 'package:shopping_home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_home/enums.dart';
import 'package:shopping_home/models/show_products.dart';
import 'package:shopping_home/screens/home/components/body.dart';

import '../../controllers/show_products_controller.dart';
import '../../size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/Home";
  const HomeScreen({Key? key}) : super(key: key);
  static List<ShowProducts> controller = ShowProductsController.allProducts;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
