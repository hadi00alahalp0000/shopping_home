import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/search_controller.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  //SearchController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      //height: 50,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onSubmitted: (value) async {
          // Go To Search After Put Values
          SearchController controller = Get.put(SearchController());
          SearchController.values = value;
          controller.search();
          Get.toNamed("/Search");
          //await clickonSearch();
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search Product",
          prefixIcon: const Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(12),
          ),
        ),
      ),
    );
  }

  // Future<void> clickonSearch() async {
  //   EasyLoading.show(status: 'loading...');
  //   //await controller.searchForProduct();

  //   //ShowProducts searchproducts; delete the List<List<dynamic>> searchproducts then uncomment this
  //   //List<List<dynamic>> searchproducts = controller.prods;

  //   EasyLoading.showSuccess('Done');
  //   Get.toNamed("/Search");
  // }
}
