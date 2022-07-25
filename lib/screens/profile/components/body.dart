import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/profile_controller.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/controllers/sign_out_controller.dart';
import 'package:shopping_home/models/secure_storage.dart';
import 'package:shopping_home/models/user_information.dart';

import '../../../size_config.dart';
import '../../../components/menu_button.dart';
import '../../../components/profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  final List locale = [
    {'locale': const Locale('en')},
    {'locale': const Locale('ar')},
  ];

  updateLanguage(Locale locale) {
    // Get.back();
    Get.updateLocale(locale);
  }

  static double widthArabic = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                Column(
                  children: [
                    Text(
                      "profile".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: getProportionateScreenWidth(10)),
                    const SizedBox(height: 20),
                    const ProfileImage(
                      // Here The Guest Can Enter
                      st: false,
                      id: -5,
                      imgUrl: '',
                    ),
                    const SizedBox(height: 30),
                    MenuButton(
                        text: "account".tr,
                        icon: "assets/icons/User Icon.svg",
                        press: () {
                          ProfileController controller =
                              Get.put(ProfileController());
                          controller.getaccount();
                        }),
                    MenuButton(
                      text: "My Products".tr,
                      icon: "assets/icons/icons8-product-16.svg",
                      press: () {
                        ShowProductsController controller =
                            Get.put(ShowProductsController());
                        controller.getProducts(
                            ConstServer.showAllMyProducts, 'nothing', 0);
                        //Get.toNamed('/My_Products');
                      },
                    ),
                    MenuButton(
                      text: "language".tr,
                      icon: "assets/icons/icons8-globe-50.svg",
                      press: () async {
                        if (UserInformation.languge == 'true') {
                          SecureStorage storage = SecureStorage();
                          UserInformation.languge = 'false';
                          await storage.save(
                              'language', UserInformation.languge!);
                          updateLanguage(locale[1]['locale']);
                          widthArabic = 2.7;
                          setState(() {});
                        } else {
                          SecureStorage storage = SecureStorage();
                          UserInformation.languge = 'true';
                          await storage.save(
                              'language', UserInformation.languge!);
                          updateLanguage(locale[0]['locale']);
                          widthArabic = 0;
                          setState(() {});
                        }
                      },
                    ),
                    MenuButton(
                      text: "Change Theme".tr,
                      icon: "assets/icons/Star Icon.svg",
                      press: () => {},
                    ),
                    MenuButton(
                      text: "out".tr,
                      icon: "assets/icons/Log out.svg",
                      press: () async {
                        SignOutController controller =
                            Get.put(SignOutController());
                        controller.logingOut();
                        // EasyLoading.show(status: 'IS Loading...'.tr);
                        // SecureStorage storage = SecureStorage();
                        // await storage.save('token', '');
                        // UserInformation.myToken == null;
                        // Get.offAllNamed('/Splash');
                        // EasyLoading.showSuccess('Logged Out'.tr);
                      },
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
