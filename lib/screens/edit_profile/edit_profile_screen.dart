import 'package:flutter/material.dart';
import 'package:shopping_home/models/my_profile.dart';

import '../../size_config.dart';
import '../profile/components/custom_app_bar.dart';
import 'components/body.dart';

class EditProfileScreen extends StatelessWidget {
  static String routeName = "/edit_profile";
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ProfileArguments arguments = ProfileArguments();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      arguments =
          ModalRoute.of(context)?.settings.arguments as ProfileArguments;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const CustomAppBar(),
      ),
      body: Body(account: arguments.account!),
    );
  }
}

class ProfileArguments {
  final MyProfile? account;
  ProfileArguments({this.account});
}
