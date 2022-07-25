import 'package:flutter/material.dart';
import 'package:shopping_home/screens/edit_details/components/body.dart';

import '../../models/show_products.dart';
import '../../size_config.dart';
import 'components/custom_app_bar.dart';

class EditDetailsScreen extends StatelessWidget {
  static String routeName = "/edit_details";
  const EditDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final EditProductDetailsArguments arguments = ModalRoute.of(context)!
        .settings
        .arguments as EditProductDetailsArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const CustomAppBar(),
      ),
      body: Body(
        product: arguments.product,
      ),
    );
  }
}

class EditProductDetailsArguments {
  final ShowProducts product;
  EditProductDetailsArguments({required this.product});
}
