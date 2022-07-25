import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(75)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/images/success.png",
            height: SizeConfig.screenHeight * 0.4,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Sign In Success".tr,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "Go to home".tr,
              press: () {
                ShowProductsController controller =
                    Get.put(ShowProductsController());
                controller.getProducts(
                    ConstServer.showAllMyProducts, 'nothing', 0);
                //clickonsortProducts();
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // void clickonsortProducts() async {
  //   EasyLoading.show(status: 'loading...'.tr);
  //   AllProductController.value = 'all';
  //   await HomeScreen.control.sortProduct();
  //   Get.offAllNamed('/Home');
  //   EasyLoading.showSuccess('Done'.tr, duration: const Duration(seconds: 1));
  // }
}
