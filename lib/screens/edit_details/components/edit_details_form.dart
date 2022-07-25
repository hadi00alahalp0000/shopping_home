import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/custom_suffix_icon.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/components/form_error.dart';
import 'package:shopping_home/controllers/edit_product_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/models/show_products.dart';
import '../../../components/product_pic.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class EditDetailsForm extends StatefulWidget {
  final ShowProducts product;
  const EditDetailsForm({Key? key, required this.product}) : super(key: key);

  @override
  EditDetailsFormState createState() => EditDetailsFormState();
}

class EditDetailsFormState extends State<EditDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          ProductPic(
            id: widget.product.id,
            imgUrl: widget.product.imgUrl,
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
            text: "Edit".tr,
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                //if all valid edit the product then go to product Details
                EditProductController controller =
                    Get.put(EditProductController());
                EditProductController.name = widget.product.name;
                EditProductController.description = widget.product.description;
                EditProductController.category = widget.product.categoryId.name;
                EditProductController.price = widget.product.price;
                EditProductController.quantity = widget.product.quantity;
                EditProductController.phone_number =
                    widget.product.contactId.phoneNumber;
                EditProductController.contact_email =
                    widget.product.contactId.contactEmail;
                EditProductController.facebook_url =
                    widget.product.contactId.facebookUrl;
                EditProductController.telegram_url =
                    widget.product.contactId.telegramUrl;
                EditProductController.whatsapp =
                    widget.product.contactId.whatsapp;
                EditProductController.skype = widget.product.contactId.skype;
                EditProductController.twitter =
                    widget.product.contactId.twitter;
                await controller.editProduct(widget.product.id);
                if (controller.message == 'true') {
                  EasyLoading.showSuccess(CasesFromServer.done.tr);
                  Get.toNamed(
                    '/Details',
                    arguments: ProductDetailsArguments(
                      product: widget.product,
                    ),
                  );
                }
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
  //   await editDetailsController.editDetails();

  //   if (editDetailsController.edited) {
  //     EasyLoading.showSuccess('Done'.tr);
  //     Get.toNamed(
  //       '/Details',
  //       arguments: ProductDetailsArguments(
  //         product: widget.product,
  //       ),
  //     );
  //   } else {
  //     EasyLoading.showError(editDetailsController.message);
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
      initialValue: widget.product.name,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => widget.product.name = newValue!,
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
      initialValue: widget.product.description,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => widget.product.description = newValue!,
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
      initialValue: widget.product.price.toString(),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => widget.product.price = int.parse(newValue!),
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
      initialValue: widget.product.categoryId.name,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => widget.product.categoryId.name = newValue!,
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
      initialValue: widget.product.contactId.phoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => widget.product.contactId.phoneNumber = newValue!,
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
      initialValue: widget.product.quantity.toString(),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => widget.product.quantity = int.parse(newValue!),
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
      initialValue: widget.product.contactId.contactEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => widget.product.contactId.contactEmail = newValue!,
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
      initialValue: widget.product.contactId.facebookUrl,
      keyboardType: TextInputType.url,
      onSaved: (newValue) => widget.product.contactId.facebookUrl = newValue!,
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
      initialValue: widget.product.contactId.telegramUrl,
      keyboardType: TextInputType.url,
      onSaved: (newValue) => widget.product.contactId.telegramUrl = newValue!,
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
      initialValue: widget.product.contactId.whatsapp,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => widget.product.contactId.whatsapp = newValue!,
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
      initialValue: widget.product.contactId.skype,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => widget.product.contactId.skype = newValue!,
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
      initialValue: widget.product.contactId.twitter,
      keyboardType: TextInputType.url,
      onSaved: (newValue) => widget.product.contactId.twitter = newValue!,
      decoration: InputDecoration(
          labelText: "twitter".tr,
          hintText: "enter twitter".tr,
          hintStyle: const TextStyle(fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              const CustomSuffixIcon(svgIcon: "assets/icons/twitter.svg")),
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
