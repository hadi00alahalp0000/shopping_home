import 'package:flutter/material.dart';

import '../../../models/my_profile.dart';
import '../../../size_config.dart';
import 'profile_details_form.dart';

class Body extends StatelessWidget {
  final MyProfile account;

  const Body({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                ProfileDetailsForm(account: account),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
