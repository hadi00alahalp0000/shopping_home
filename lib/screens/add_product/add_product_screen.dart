import 'package:flutter/material.dart';
import 'package:shopping_home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_home/screens/add_product/components/body.dart';

import '../../enums.dart';
import '../../size_config.dart';

class AddProductScreen extends StatelessWidget {
  static String routeName = "/add_product";
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.add),
    );
  }
}
