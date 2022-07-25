import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/screens/complete_profile/components/body.dart';

import '../../size_config.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            widthFactor: SizeConfig.screenWidth * 0.0115 - 1,
            child: Text(
              "Complete Profile".tr,
            )),
      ),
      body: const Body(),
    );
  }
}
