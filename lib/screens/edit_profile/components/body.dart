// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/models/my_profile.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'edit_profile_form.dart';

class Body extends StatelessWidget {
  final MyProfile account;

  Body({Key? key, required this.account}) : super(key: key);

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
                Center(
                  widthFactor: getProportionateScreenWidth(4.5),
                  child: Text(
                    "Edit profile Details".tr,
                    style: headingStyle,
                  ),
                ),
                Text(
                  "Edit your profile details".tr,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                EditProfileForm(account: account),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
