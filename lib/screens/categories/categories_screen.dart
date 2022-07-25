import 'package:flutter/material.dart';
import 'package:shopping_home/controllers/category_controller.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../models/category.dart';
import 'components/body.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static List<Category> categories = CategoryController.categories;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.categories),
    );
  }
}
