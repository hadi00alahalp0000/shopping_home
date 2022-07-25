import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../size_config.dart';
import 'components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          widthFactor: SizeConfig.screenWidth * 0.0055,
          child: Text("Change Password".tr),
        ),
      ),
      body: const Body(),
    );
  }
}
