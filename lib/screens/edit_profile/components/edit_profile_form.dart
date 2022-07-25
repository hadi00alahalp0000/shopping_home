import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_home/components/custom_suffix_icon.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/components/form_error.dart';
import 'package:shopping_home/controllers/edit_profile_controller.dart';
import 'package:shopping_home/models/my_profile.dart';
import '../../../components/date_picker_widget.dart';
import '../../../components/profile_pic.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class EditProfileForm extends StatefulWidget {
  final MyProfile account;

  //User? account;
  const EditProfileForm({Key? key, required this.account}) : super(key: key);

  @override
  EditProfileFormState createState() => EditProfileFormState();
}

class EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  EditProfileController controller = Get.put(EditProfileController());

  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          
          ProfileImage(
              st: true,
              id: widget.account.user[0].id!,
              imgUrl: widget.account.user[0].profileImgUrl ?? 'null'),
          SizedBox(height: getProportionateScreenHeight(50)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DatePickerWidget(
            txt: "BirthDate".tr,
            initdate: DateFormat('yyyy/MM/dd')
                .format(widget.account.user[0].birthdate),
            inputdate: widget.account.user[0].birthdate,
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
            text: "Edit".tr,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                // if all valid edit the product then go to profile

                EditProfileController.id = widget.account.user[0].id;
                EditProfileController.firstname =
                    widget.account.user[0].firstname;
                EditProfileController.lastname =
                    widget.account.user[0].lastname;

                EditProfileController.birthdate =
                    widget.account.user[0].birthdate;
                EditProfileController.governorate =
                    widget.account.address[0].governorate;
                EditProfileController.region = widget.account.address[0].region;
                EditProfileController.street = widget.account.address[0].street;
                EditProfileController.contact_email =
                    widget.account.contactInformations[0].contactEmail;
                EditProfileController.phone_number =
                    widget.account.contactInformations[0].phoneNumber;
                EditProfileController.facebook_url =
                    widget.account.contactInformations[0].facebookUrl;
                EditProfileController.telegram_url =
                    widget.account.contactInformations[0].telegramUrl;
                EditProfileController.whatsapp =
                    widget.account.contactInformations[0].whatsapp;
                EditProfileController.skype =
                    widget.account.contactInformations[0].skype;
                controller.editProfile();

                //clickonedit();
              }
            },
          ),
        ],
      ),
    );
  }

  // void clickonedit() async {
  //   EasyLoading.show(status: 'loading...'.tr);
  //   await editprofilecontroller.editProfile();
  //   if (editprofilecontroller.edited) {
  //     EasyLoading.showSuccess('Done'.tr);

  //     ProfileController profilecontroller = Get.put(ProfileController());
  //     EasyLoading.show(status: 'loading...'.tr);
  //     await profilecontroller.getaccount();
  //     Get.offNamed('/Profile');
  //     EasyLoading.showSuccess('', duration: const Duration(seconds: 1));
  //   } else {
  //     EasyLoading.showError(editprofilecontroller.message);
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
      initialValue: widget.account.user[0].firstname,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => widget.account.user[0].firstname = newValue!,
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
      initialValue: widget.account.user[0].lastname,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => widget.account.user[0].lastname = newValue!,
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
      initialValue: widget.account.contactInformations[0].phoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) =>
          widget.account.contactInformations[0].phoneNumber = newValue!,
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
      initialValue: widget.account.address[0].governorate,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => widget.account.address[0].governorate = newValue!,
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
      initialValue: widget.account.address[0].region,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => widget.account.address[0].region = newValue!,
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
      initialValue: widget.account.address[0].street,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => widget.account.address[0].street = newValue!,
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
      initialValue: widget.account.contactInformations[0].contactEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) =>
          widget.account.contactInformations[0].contactEmail = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidContactEmailError);
        }
        if (value.isNotEmpty && !emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidContactEmailError);
        } else {
          removeError(error: kInvalidContactEmailError);
        }
        return;
      },
      // validator: (value) {
      //   if (value != null && !emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidContactEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
          labelText: "Contact Email".tr,
          hintText: "Enter your contact email".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg")),
    );
  }

  TextFormField buildFacebookURLFormField() {
    return TextFormField(
      //initialValue: widget.account.facebook_url,
      keyboardType: TextInputType.url,
      //onSaved: (newValue) => widget.account.facebook_url = newValue!,
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
      //initialValue: widget.account.telegram_url,
      keyboardType: TextInputType.url,
      //onSaved: (newValue) =>  widget.account.telegram_url = newValue!,
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
      //initialValue: widget.account.whatsapp,
      keyboardType: TextInputType.phone,
      // onSaved: (newValue) => widget.account.whatsapp = newValue!,
      decoration: InputDecoration(
          labelText: "WhatsApp Phone Number".tr,
          hintText: "Enter your whatsapp phone number".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/whatsapp-svgrepo-com.svg")),
    );
  }

    TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => EditProfileController.password = newValue!,
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

  TextFormField buildSkypePhoneNumberFormField() {
    return TextFormField(
      //initialValue: widget.account.skype,
      keyboardType: TextInputType.text,
      //onSaved: (newValue) => EditProfileController.skype = newValue!,
      decoration: InputDecoration(
          labelText: "Skype Phone Number".tr,
          hintText: "Enter your skype phone number".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/skype-svgrepo-com.svg")),
    );
  }

  String nullcheckstring(String? s) {
    if (s == null) {
      return " ";
    } else {
      return s;
    }
  }
}

