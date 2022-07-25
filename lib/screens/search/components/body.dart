// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:shopping_home/components/product_card.dart';
import 'package:shopping_home/constants.dart';
import 'package:shopping_home/controllers/search_controller.dart';
import 'package:shopping_home/models/my_profile.dart';
import 'package:shopping_home/models/show_products.dart';
import 'package:shopping_home/screens/details/details_screen.dart';
import '../../../size_config.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SearchController controller = Get.find();
  List<ShowProducts> products = SearchController.productsResult;
  List<MyProfile> users = SearchController.usersResult;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(5)),
          Text(
            "Search In Products By".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          CustomRadioButton(
            elevation: 0,
            absoluteZeroSpacing: false,
            autoWidth: true,
            enableButtonWrap: true,
            enableShape: true,
            unSelectedColor: Theme.of(context).canvasColor,
            buttonLables: [
              'Name'.tr,
              'Category'.tr,
              'Expiry Date'.tr,
            ],
            buttonValues: const [
              "name",
              "category",
              "exp_date",
            ],
            buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.black,
                textStyle: TextStyle(fontSize: 16)),
            radioButtonValue: (value) {
              SearchController.searchType = value as String;
              //controller.searchby = value as String;
            },
            selectedColor: kPrimaryColor,
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Container(
            width: SizeConfig.screenWidth * 0.6,
            //height: 50,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onSubmitted: (value) async {
                //search value

                SearchController.values = value;
                controller.search();
                products = SearchController.productsResult;
                users = SearchController.usersResult;
                //controller.searchvalue = value;
                //await clickonSearch();
                setState(() {});
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Search Product".tr,
                prefixIcon: const Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(12),
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Text(
            "Search Results".tr,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Flexible(child: Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                  strokeWidth: 3,
                ),
              );
            }
            return GridView.count(
              childAspectRatio: 0.65,
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              children: [
                ...List.generate(
                  products.length,
                  // controller.prods.length,
                  (index) => ProductCard(
                    product: products[index],
                    //product: controller.prods[index],
                    press: () async {
                      //AllProductController.index = index;
                      // PurpleProduct product =
                      //     PurpleProduct.fromJson(controller.prods[index][0]);
                      // String? token = UserInformation.myToken;
                      // var view = await http.get(
                      //   Uri.parse(ConstServer.domaiNname +
                      //       "/api/views/" +
                      //       product.id.toString()),
                      //   headers: {'token': '$token'},
                      // );
                      // print(view.body);
                      Get.toNamed(
                        '/Details',
                        arguments: ProductDetailsArguments(
                          product: products[index],
                        ),
                      );
                    },
                  ),

                  //     ProductSearchCard(
                  //   product: SearchController.prods[0][index],
                  //   press: () {},
                  // ),
                ),
                // ...List.generate(
                //   users.length,
                //   (index) => UserCard(
                //     user: users[index],
                //     press: () async {
                //       Get.toNamed(
                //         '/Profile_Details',
                //         arguments: ProfileArguments(
                //           account: users[index],
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            );
          })),
        ],
      ),
    );
  }

  // Future<void> clickonSearch() async {
  //   EasyLoading.show(status: 'loading...'.tr);
  //   await controller.searchForProduct();
  //   //print(prods);
  //   EasyLoading.showSuccess('Done'.tr);
  // }
}
