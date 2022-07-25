import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/screens/otp/components/body.dart';

import '../../size_config.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            widthFactor: SizeConfig.screenWidth * 0.00599,
            child: Text("OTP Verification".tr)),
      ),
      body: const Body(),
    );
  }
}
