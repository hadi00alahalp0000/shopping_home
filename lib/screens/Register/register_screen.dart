import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/screens/Register/components/body.dart';

import '../../size_config.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/regester";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            widthFactor: SizeConfig.screenWidth * 0.0115 - 1,
            child: Text("Register".tr)),
      ),
      body: const Body(),
    );
  }
}
