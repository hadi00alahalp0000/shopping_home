import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/screens/sign_in/components/body.dart';
import 'package:shopping_home/size_config.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          widthFactor: SizeConfig.screenWidth,
          child: Text("Sign In".tr),
        ),
      ),
      body: const Body(),
    );
  }
}
