import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../models/my_profile.dart';
import '../../size_config.dart';
import 'components/body.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ProfileDetailsArguments arguments = ProfileDetailsArguments();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      arguments =
          ModalRoute.of(context)?.settings.arguments as ProfileDetailsArguments;
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile Details".tr,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Body(account: arguments.account!),
    );
  }
}

class ProfileDetailsArguments {
  final MyProfile? account;
  ProfileDetailsArguments({this.account});
}
