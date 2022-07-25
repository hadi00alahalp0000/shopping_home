import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/category_controller.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/controllers/wallet_controller.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  void clickonProfile() {
    // ProfileController controller = Get.put(ProfileController());
    // await controller.getaccount();
    Get.toNamed('/Profile');
  }

  void clickonHome() {
    ShowProductsController controller = Get.put(ShowProductsController());
    controller.getProducts(ConstServer.showAllProducts, 'nothing', 0);
  }

  void clickonCategory() {
    CategoryController controller = Get.put(CategoryController());
    controller.getCategories();
  }

  void clickonWallet() {
    WalletController controller = Get.put(WalletController());
    controller.getWallet();
  }

  void clickonAddProduct() {
    Get.toNamed('/addProduct');
  }

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => clickonHome(),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/icons8-category-50.svg",
                  color: MenuState.categories == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  width: 20,
                  height: 20,
                ),
                onPressed: () => clickonCategory(),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Plus Icon.svg",
                  color: MenuState.add == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  width: 20,
                  height: 20,
                ),
                onPressed: () => clickonAddProduct(),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/wallet-svgrepo-com.svg",
                  color: MenuState.wallet == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  width: 20,
                  height: 20,
                ),
                onPressed: () => clickonWallet(),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => clickonProfile(),
              ),
            ],
          )),
    );
  }
}
