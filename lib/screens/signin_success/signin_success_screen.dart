import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/screens/signin_success/components/body.dart';

import '../../size_config.dart';

class SignInSuccessScreen extends StatelessWidget {
  static String routeName = "/signin_success";
  const SignInSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          widthFactor: SizeConfig.screenWidth * 0.0062,
          child: Text("Sign In Success".tr),
        ),
      ),
      body: const Body(),
    );
  }
}
