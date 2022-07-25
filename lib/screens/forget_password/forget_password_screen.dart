import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../forget_password/components/body.dart';

import '../../size_config.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forget_password";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          widthFactor: SizeConfig.screenWidth * 0.0055,
          child: Text("Forgot Password".tr),
        ),
      ),
      body: const Body(),
    );
  }
}
