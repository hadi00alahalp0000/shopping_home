// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/default_button.dart';
import 'package:shopping_home/controllers/add_product_to_my_order_controller.dart';
import 'package:shopping_home/controllers/delete_product_controller.dart';
import 'package:shopping_home/controllers/view_controller.dart';
import 'package:shopping_home/screens/edit_details/edit_details_screen.dart';
import 'package:shopping_home/size_config.dart';

import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';
import '../../../models/show_products.dart';
import 'price_quantity.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final ShowProducts product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: Row(
                    children: [
                      Text(
                        "${widget.product.numStar}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset("assets/icons/Star Icon.svg"),
                      const SizedBox(width: 20),
                      Text(
                        "${widget.product.numReviews}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset("assets/icons/User Icon.svg"),
                    ],
                  ),
                ),
              ),
              ProductDescription(
                product: widget.product,
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    PriceQuantity(product: widget.product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: (ViewController.isMine == false)
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order Quantity :'.tr,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              getProportionateScreenWidth(10)),
                                      RoundedIconBtn(
                                        iconData: Icons.remove,
                                        press: () {
                                          if (AddProductToMyOrderController
                                                  .quantities >
                                              1) {
                                            AddProductToMyOrderController
                                                .quantities--;
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: AddProductToMyOrderController
                                                .quantities
                                                .toString()
                                                .length
                                                .toDouble() *
                                            1500 /
                                            100,
                                        child: TextFormField(
                                          initialValue:
                                              "${AddProductToMyOrderController.quantities}",
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                          decoration: otpInputDecoration,
                                          onChanged: (value) {
                                            if (int.parse(value) < 1) {
                                              value = '1';
                                            }
                                            AddProductToMyOrderController
                                                .quantities = int.parse(value);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      RoundedIconBtn(
                                        iconData: Icons.add,
                                        press: () {
                                          if (AddProductToMyOrderController
                                                  .quantities <
                                              widget.product.quantity) {
                                            AddProductToMyOrderController
                                                .quantities++;
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.15,
                                    right: SizeConfig.screenWidth * 0.15,
                                    top: getProportionateScreenWidth(15),
                                    bottom: getProportionateScreenWidth(40),
                                  ),
                                  child: DefaultButton(
                                    text: "Add To Cart".tr,
                                    press: () {
                                      // add to cart method
                                      AddProductToMyOrderController controller =
                                          Get.put(
                                              AddProductToMyOrderController());
                                      controller.addProductToMyOrder(
                                          widget.product.id);
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(25),
                                  ),
                                  height: SizeConfig.screenHeight * 0.07,
                                  width: SizeConfig.screenWidth * 0.5,
                                  child: DefaultButton(
                                    clr: Colors.purple,
                                    text: "Edit".tr,
                                    press: () {
                                      Get.toNamed(
                                        '/editDetails',
                                        arguments: EditProductDetailsArguments(
                                          product: widget.product,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(25),
                                  ),
                                  height: SizeConfig.screenHeight * 0.07,
                                  width: SizeConfig.screenWidth * 0.5,
                                  child: DefaultButton(
                                    clr: Colors.red,
                                    text: "Delete".tr,
                                    press: () {
                                      DeleteProductController controller =
                                          Get.put(DeleteProductController());
                                      controller
                                          .deleteMyProduct(widget.product.id);
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void clickondelete() async {
  //   EasyLoading.show(status: "loading...".tr);
  //   await HomeScreen.control.deleteonclick(HomeScreen.control.delid);
  //   if (HomeScreen.control.deleteStatus) {
  //     EasyLoading.showSuccess(HomeScreen.control.message);
  //     Get.toNamed('/Home');
  //   } else {
  //     EasyLoading.showError(HomeScreen.control.message);
  //   }
  // }
}
