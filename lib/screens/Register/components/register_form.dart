// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/custom_suffix_icon.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/components/form_error.dart';
import 'package:shopping_home/controllers/sign_up_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue".tr,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                clickonregister();
                //if all valid then go to profile screen
              }
            },
          ),
        ],
      ),
    );
  }

  void clickonregister() async {
    await EasyLoading.show(status: CasesFromServer.loading.tr);
    Get.toNamed('/completeProfile');
    EasyLoading.showSuccess(
      'Complete Your Profile'.tr,
      duration: const Duration(
        seconds: 4,
      ),
      dismissOnTap: true,
    );
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  TextFormField buildConformPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => SignUpController.passwordConformation = newValue!,
      onChanged: (value) {
        if (SignUpController.password == value) {
          removeError(error: kMatchPassError);
        }
        SignUpController.passwordConformation = value;
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "";
        }
        if (SignUpController.password !=
            SignUpController.passwordConformation) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm Password".tr,
          hintText: "Re-enter your password".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg")),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => SignUpController.password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        SignUpController.password = value;
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password".tr,
          hintText: "Enter your password".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg")),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => SignUpController.email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Email".tr,
          hintText: "Enter your email".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg")),
    );
  }
}
