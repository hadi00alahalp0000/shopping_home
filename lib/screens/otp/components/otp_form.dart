// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/forget_password_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';
import '../../../constants.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otb = "";
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    otb = value;
                    nextField(value: value, focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    otb += value;

                    nextField(value: value, focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    otb += value;

                    nextField(value: value, focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    otb += value;
                    pin4FocusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue".tr,
            press: () {
              if (otb.length == 4) {
                if (UserInformation.otbType == CasesFromServer.signUp) {
                  // User Doing SignUp
                  SignUpController controller = Get.put(SignUpController());
                  SignUpController.otb = otb;
                  controller.signUp();
                  //clickonsortProducts();
                } else {
                  // User Doing ForgetPassword
                  ForgetPasswordController.forgetPasswordOtb = otb;
                  Get.toNamed('Change_password');
                  EasyLoading.showInfo('Input You New Password Here');
                }
              } else {
                EasyLoading.showError(
                  'Enter OTB !!'.tr,
                  duration: const Duration(
                    seconds: 4,
                  ),
                  dismissOnTap: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // void clickonsortProducts() async {
  //   if (SignUpController.otb.length == 4) {
  //     SignUpController controller = Get.put(SignUpController());

  //     await profile.registeronclick();

  //     if (SignUpController.registerstatus) {
  //       EasyLoading.show(status: 'loading...'.tr);
  //       AllProductController.value = 'all';
  //       await HomeScreen.control.sortProduct();
  //       Get.offAllNamed('/Home');
  //       EasyLoading.showSuccess('Done'.tr,
  //           duration: const Duration(seconds: 1));
  //     }
  //   } else {
  //     EasyLoading.showError('Enter OTB !!'.tr,
  //         duration: const Duration(seconds: 4), dismissOnTap: true);
  //   }
  // }
}
