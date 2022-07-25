import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/like_controller.dart';
import 'package:shopping_home/controllers/review_controller.dart';
import 'package:shopping_home/models/cases_from_server.dart';
import 'package:shopping_home/screens/review/review_screen.dart';

import '../../../constants.dart';
import '../../../models/show_products.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ShowProducts product;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    //HomeScreen.control.catid = widget.product.categoryId.id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 6),
              Text(
                '\$ ${widget.product.price}',
                style: const TextStyle(
                    fontSize: 18.5, color: Colors.deepOrangeAccent),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                // Go To Show All Review
                ReviewController controller = Get.put(ReviewController());
                await controller.getAllReviewsByProductId(widget.product.id);
                Get.toNamed('/review',
                    arguments: ReviewsArguments(
                      reviews: ReviewController.reviews,
                      product: widget.product,
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  color: Colors.blue[900],
                  height: getProportionateScreenWidth(16),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                // String? token = UserInformation.myToken;
                // if (!HomeScreen.control.islike[widget.product.id]) {
                //   var likes = await http.post(
                //     Uri.parse(
                //         "${ConstServer.domaiNname}/api/like/store/${widget.product.id}"),
                //     headers: {'token': '$token'},
                //   );

                //   if (likes.statusCode == 200) {
                //     HomeScreen.control.islike[widget.product.id] = true;
                //   }
                // } else {
                //   var likes = await http.get(
                //     Uri.parse(
                //         "${ConstServer.domaiNname}/api/like/delete/${widget.product.id}"),
                //     headers: {'token': '$token'},
                //   );
                //   if (likes.statusCode == 200) {
                //     HomeScreen.control.islike[widget.product.id] = false;
                //   }
                // }

                // this is what you want to know if the products have your like or not
                // ViewController.isFavourite;
                LikeController controller = Get.put(LikeController());
                await controller.addLike(widget.product.id);
                if (controller.message == CasesFromServer.youAddedLike) {
                  //HomeScreen.control.islike[widget.product.id!] = true;
                } else {
                  //HomeScreen.control.islike[widget.product.id!] = false;
                }

                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  // color: !HomeScreen.control.islike[widget.product.id!]
                  //     ? const Color(0xFFDBDEE4)
                  //     : const Color(0xFFFF4848),
                  // height: getProportionateScreenWidth(16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${"c".tr} : \n', //+ HomeScreen.control.catename[widget.product.id!],
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Contact Information:".tr,
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Text(
                "${"pca".tr} : ",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              Text(
                nullcheckstring(widget.product.contactId.contactEmail),
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "${"cpn".tr} : \n${nullcheckstring(widget.product.contactId.phoneNumber)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "${"Facebook URL".tr} : \n${nullcheckstring(widget.product.contactId.facebookUrl)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "${"Telegram URL".tr} : \n${nullcheckstring(widget.product.contactId.telegramUrl)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "${"WhatsApp Phone Number".tr} : \n${nullcheckstring(widget.product.contactId.whatsapp)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "${"Skype Phone Number".tr} : \n${nullcheckstring(widget.product.contactId.skype)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "${"twitter".tr} : \n${nullcheckstring(widget.product.contactId.twitter)}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            ],
          ),
        ),
      ],
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
