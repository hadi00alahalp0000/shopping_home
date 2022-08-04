import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/show_products_controller.dart';
import 'package:shopping_home/screens/home/components/home_header.dart';
import 'package:shopping_home/screens/home/components/section_title.dart';
import 'package:shopping_home/screens/home/components/all_products.dart';
import 'package:shopping_home/size_config.dart';

import '../../../constants.dart';
import '../home_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => BodyState();
  
}

class BodyState extends State<Body> {
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortl = [
      {"icon": "assets/icons/receipt.svg", "text": "Name".tr},
      {"icon": "assets/icons/Cash.svg", "text": "Price".tr},
      {"icon": "assets/icons/Heart Icon_2.svg", "text": "Likes".tr},
      {"icon": "assets/icons/icons8-view-64.svg", "text": "Views".tr},
    ];

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(5)),
          Text(
            "Home".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: getProportionateScreenWidth(15)),
          const HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              children: [
                SectionTitle(
                  text: "Sort Products By".tr,
                  press: () {},
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      sortl.length,
                      (index) => SortCard(
                        icon: sortl[index]["icon"],
                        text: sortl[index]["text"],
                        press: () async {
                          switch (index) {
                            case 0:
                              ShowProductsController con =
                                  Get.put(ShowProductsController());
                              await con.getProducts(
                                  ConstServer.showAllSortedProducts,
                                  'sort_by_name',
                                  0);
                              HomeScreen.controller =
                                  ShowProductsController.sortedProducts;
                              setState(() {});
                              break;

                            case 1:
                              ShowProductsController con =
                                  Get.put(ShowProductsController());
                              await con.getProducts(
                                  ConstServer.showAllSortedProducts,
                                  'price',
                                  0);
                              HomeScreen.controller =
                                  ShowProductsController.sortedProducts;
                              setState(() {});
                              break;

                            case 2:
                              ShowProductsController con =
                                  Get.put(ShowProductsController());
                              await con.getProducts(
                                  ConstServer.showAllSortedProducts,
                                  'sort_by_price',
                                  0);
                              HomeScreen.controller =
                                  ShowProductsController.sortedProducts;
                              setState(() {});
                              break;

                            case 3:
                              ShowProductsController con =
                                  Get.put(ShowProductsController());
                              await con.getProducts(
                                  ConstServer.showAllSortedProducts,
                                  'num_views',
                                  0);
                              HomeScreen.controller =
                                  ShowProductsController.sortedProducts;
                              setState(() {});
                              break;

                            case 4:
                              ShowProductsController con =
                                  Get.put(ShowProductsController());
                              await con.getProducts(
                                  ConstServer.showAllSortedProducts,
                                  'num_views',
                                  0);
                              HomeScreen.controller =
                                  ShowProductsController.sortedProducts;
                              setState(() {});
                              break;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // SizedBox(height: getProportionateScreenWidth(30)),
          // const SpecialOffers(),
          SizedBox(height: getProportionateScreenWidth(10)),
          const Expanded(child: AllProducts()),
          SizedBox(height: getProportionateScreenWidth(5)),
        ],
      ),
    );
  }
}

class SortCard extends StatelessWidget {
  const SortCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon, color: kPrimaryColor),
              ),
            ),
            const SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
