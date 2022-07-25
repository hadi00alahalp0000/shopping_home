import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/custom_suffix_icon.dart';
import 'package:shopping_home/components/date_picker_widget.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/components/form_error.dart';
import 'package:shopping_home/components/profile_pic.dart';
import 'package:shopping_home/controllers/sign_up_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/user_information.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  CompleteProfileFormState createState() => CompleteProfileFormState();
}

SignUpController controller = Get.put(SignUpController());

final List<String> errors = [];

class CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const ProfileImage(
            st: true,
            id: -5,
            imgUrl: '',
          ),
          SizedBox(height: getProportionateScreenHeight(50)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DatePickerWidget(
            txt: "BirthDate".tr,
            inputdate: SignUpController.birthdate,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGovernorateFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildRegionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStreetFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildContactEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFacebookURLFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTelegramURLFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildWhatsappPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSkypePhoneNumberFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue".tr,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                UserInformation.otbType = CasesFromServer.signUp;
                controller.checkotb();
                Get.toNamed('/OTB');
                //clickonregister();
                //if all valid then go to otp screen

              }
            },
          ),
        ],
      ),
    );
  }

  // void clickonregister() async {
  //   CompleteProfileController profile = Get.put(CompleteProfileController());
  //   EasyLoading.show(status: 'loading...'.tr);
  //   await profile.checkotb();
  //   if (CompleteProfileController.otbstatus) {
  //     Get.toNamed('/OTB');
  //     EasyLoading.showError('Enter OTB !!'.tr,
  //         duration: const Duration(seconds: 10), dismissOnTap: true);
  //   } else {
  //     EasyLoading.showError(CompleteProfileController.message,
  //         duration: const Duration(seconds: 10), dismissOnTap: true);
  //   }
  // }

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

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => SignUpController.firstname = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kFirstNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "First Name".tr,
          hintText: "Enter your first name".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/User.svg")),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => SignUpController.lastname = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kLastNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Last Name".tr,
          hintText: "Enter your last name".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/User Icon.svg")),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => SignUpController.phone_number = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Phone Number".tr,
          hintText: "Enter your phone number".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg")),
    );
  }

  TextFormField buildGovernorateFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => SignUpController.governorate = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kGovernorateNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kGovernorateNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Governorate".tr,
        hintText: "Enter your Governorate".tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            const CustomSuffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildRegionFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => SignUpController.region = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kRegionNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kRegionNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Region".tr,
        hintText: "Enter your Region".tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            const CustomSuffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildStreetFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => SignUpController.street = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kStreetNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kStreetNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Street".tr,
        hintText: "Enter your Street".tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            const CustomSuffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildContactEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => SignUpController.contact_email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidContactEmailError);
        }
        return;
      },
      validator: (value) {
        if (value != null && !emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidContactEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Contact Email".tr,
          hintText: "Enter your contact email".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg")),
    );
  }

  TextFormField buildFacebookURLFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => SignUpController.facebook_url = newValue!,
      decoration: InputDecoration(
          labelText: "Facebook URL".tr,
          hintText: "Enter your Facebook URL".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/facebook-2.svg")),
    );
  }

  TextFormField buildTelegramURLFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => SignUpController.telegram_url = newValue!,
      decoration: InputDecoration(
          labelText: "Telegram URL".tr,
          hintText: "Enter your Telegram URL".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/telegram-svgrepo-com.svg")),
    );
  }

  TextFormField buildWhatsappPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => SignUpController.whatsapp = newValue!,
      decoration: InputDecoration(
          labelText: "WhatsApp Phone Number".tr,
          hintText: "Enter your whatsapp phone number".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/whatsapp-svgrepo-com.svg")),
    );
  }

  TextFormField buildSkypePhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => SignUpController.skype = newValue!,
      decoration: InputDecoration(
          labelText: "Skype Phone Number".tr,
          hintText: "Enter your skype phone number".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/skype-svgrepo-com.svg")),
    );
  }
}
