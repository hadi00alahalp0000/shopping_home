import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/custom_suffix_icon.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/components/form_error.dart';
import 'package:shopping_home/components/product_pic.dart';
import 'package:shopping_home/controllers/add_product_controller.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  AddProductFormState createState() => AddProductFormState();
}

class AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String description;
  late String category;
  late double price;
  late int quantity;
  late String phoneNumber;
  late String? imgUrl;
  late String? contactEmail;
  late String? facebookUrl;
  late String? telegramUrl;
  late String? whatsapp;
  late String? skype;
  late String? twitter;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          const ProductPic(
            id: -5,
            imgUrl: '',
          ),
          SizedBox(height: getProportionateScreenHeight(50)),
          buildProductNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductDescFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductCategoryFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductPriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductQuantityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductContactAccountFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductFacebookUrlFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductTelegramUrlFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductWhatsappFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductSkypeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductTwitterFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "add".tr,
            press: () {
              if (_formKey.currentState!.validate()) {
                
                _formKey.currentState?.save();
                //if all valid add the product then go to home screen
                AddProductController controller =
                    Get.put(AddProductController());
                AddProductController.name = name;
                AddProductController.description = description;
                AddProductController.category = category;
                AddProductController.price = price;
                AddProductController.quantity = quantity;
                AddProductController.phoneNumber = phoneNumber;
                AddProductController.contactEmail = contactEmail;
                AddProductController.facebookUrl = facebookUrl;
                AddProductController.telegramUrl = telegramUrl;
                AddProductController.whatsapp = whatsapp;
                AddProductController.skype = skype;
                AddProductController.twitter = twitter;
                controller.addProduct();
                //clickonadd();
              }
            },
          ),
        ],
      ),
    );
  }

  // late AddProductServes service = AddProductServes();
  // void clickonadd() async {
  //   AddProductController controller = Get.find();
  //   EasyLoading.show(status: 'loading...');
  //   await controller.addProduct();
  //   if (controller.added_image) {
  //     EasyLoading.showSuccess('Added Done');
  //     Get.offAllNamed('/Home');
  //   } else {
  //     EasyLoading.showError(controller.message);
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

  TextFormField buildProductNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kProductNameNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kProductNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "n".tr,
          hintText: "hn".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/icons8-product-16.svg")),
    );
  }

  TextFormField buildProductDescFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => description = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kProductDiscNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kProductDiscNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "d".tr,
          hintText: "hd".tr,
          hintStyle: const TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/icons8-product-16.svg")),
    );
  }

  TextFormField buildProductPriceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => price = double.parse(newValue!),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kProductPriceNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kProductPriceNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "pr".tr,
          hintText: "hpr".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Cash.svg")),
    );
  }

  TextFormField buildProductCategoryFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => category = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kProductCategoryNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kProductCategoryNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "c".tr,
          hintText: "hc".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/icons8-category-50.svg")),
    );
  }

  TextFormField buildProductPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kProductContactNumNullError);
        }
        return;
      },
      validator: (value) {
        if ((value == null || value.isEmpty)) {
          addError(error: kProductContactNumNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: "cpn".tr,
          hintText: "hcpn".tr,
          hintStyle: const TextStyle(fontSize: 11.3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg")),
    );
  }

  TextFormField buildProductQuantityFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => quantity = int.parse(newValue!),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kProductQuantityNullError);
        }
        return;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kProductQuantityNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "q".tr,
          hintText: "hq".tr,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/icons8-how-many-quest-50.svg")),
    );
  }

  TextFormField buildProductContactAccountFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => contactEmail = newValue!,
      decoration: InputDecoration(
          labelText: "pca".tr,
          hintText: "hpca".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/User Icon.svg")),
    );
  }

  TextFormField buildProductFacebookUrlFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => facebookUrl = newValue!,
      decoration: InputDecoration(
          labelText: "Facebook URL".tr,
          hintText: "Enter your Facebook URL".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/facebook-2.svg")),
    );
  }

  TextFormField buildProductTelegramUrlFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => telegramUrl = newValue!,
      decoration: InputDecoration(
          labelText: "Telegram URL".tr,
          hintText: "Enter your Telegram URL".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/telegram-svgrepo-com.svg")),
    );
  }

  TextFormField buildProductWhatsappFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => whatsapp = newValue!,
      decoration: InputDecoration(
          labelText: "WhatsApp Phone Number".tr,
          hintText: "Enter your whatsapp phone number".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/whatsapp-svgrepo-com.svg")),
    );
  }

  TextFormField buildProductSkypeFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => skype = newValue!,
      decoration: InputDecoration(
          labelText: "Skype Phone Number".tr,
          hintText: "Enter your skype phone number".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSuffixIcon(
              svgIcon: "assets/icons/skype-svgrepo-com.svg")),
    );
  }

  TextFormField buildProductTwitterFormField() {
    return TextFormField(
      keyboardType: TextInputType.url,
      onSaved: (newValue) => twitter = newValue!,
      decoration: InputDecoration(
          labelText: "twitter".tr,
          hintText: "enter twitter".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/twitter.svg")),
    );
  }
}
