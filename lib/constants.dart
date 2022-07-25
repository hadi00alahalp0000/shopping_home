import 'package:flutter/material.dart';
import 'package:shopping_home/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  color: Colors.black,
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp imgValidatorRegExp = RegExp(r"\.(gif|jpe?g|tiff?|png|webp|bmp)$");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kInvalidImgError = "Please Enter Valid Image Path";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kFirstNamelNullError = "Please Enter your first name";
const String kLastNamelNullError = "Please Enter your last name";
const String kPhoneNumberNullError = "Please Enter your Phone Number";
const String kGovernorateNullError = "Please Enter your governorate";
const String kRegionNullError = "Please Enter your region";
const String kStreetNullError = "Please Enter your street";
const String kContactEmailNullError = "Please Enter your contact email";
const String kInvalidContactEmailError = "Please Enter Valid Contact Email";
const String kProductNameNullError = "Please Enter your Product Name";
const String kProductDiscNullError = "Please Enter your Product Discription";
const String kProductImgNullError = "Please Enter your Product Image Path";
const String kProductCategoryNullError = "Please Enter your Product Category";
const String kProductContactNumNullError =
    "Please Enter your Product Contact Phone Number";
const String kProductContactAccountNullError =
    "Please Enter your Product Contact Account";
const String kProductQuantityNullError = "Please Enter your Product Quantity";
const String kProductPriceNullError = "Please Enter your Product Price";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kTextColor),
  );
}
