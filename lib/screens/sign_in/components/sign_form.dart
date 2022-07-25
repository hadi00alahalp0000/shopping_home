import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/custom_suffix_icon.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/components/form_error.dart';
import 'package:shopping_home/controllers/sign_in_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  SignInController sign = Get.find();

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
          Row(
            children: [
              Checkbox(
                value: sign.remember.value,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    sign.remember(value!);
                  });
                },
              ),
              Text("Remember me".tr),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed('/ForgetPassword'),
                child: Text(
                  "Forgot Password".tr,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue".tr,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                clickonsignin();
                //if all valid then go to success screen
              }
            },
          ),
        ],
      ),
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

  void clickonsignin() async {
    EasyLoading.show(status: CasesFromServer.loading.tr);
    await sign.signinonclick();
    if (sign.signIn) {
      EasyLoading.showSuccess(CasesFromServer.done.tr);
      Get.offAllNamed('/Home');
    } else {
      EasyLoading.showError(
        sign.message,
        duration: const Duration(
          seconds: 4,
        ),
      );
    }
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => sign.password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
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
      onSaved: (newValue) => sign.email = newValue!,
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
        suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
