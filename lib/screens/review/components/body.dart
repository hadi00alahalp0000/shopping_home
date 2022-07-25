import 'package:flutter/material.dart';
import 'package:shopping_home/const_server.dart';
import 'package:shopping_home/controllers/review_controller.dart';
import 'package:shopping_home/controllers/user_controller.dart';
import 'package:shopping_home/models/review.dart';
import 'package:shopping_home/models/show_products.dart';
import 'package:shopping_home/screens/review/components/review_card.dart';
import 'package:shopping_home/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../size_config.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  final List<Review> reviews;
  final ShowProducts product;
  const Body({Key? key, required this.reviews, required this.product})
      : super(key: key);

  static var text = TextEditingController();
  static String newReview = '';
  static dynamic newStars = 3;
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(5)),
          Text(
            "Reviews".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: getProportionateScreenWidth(5)),
          RatingBar.builder(
            initialRating: 3,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {
              Body.newStars = value;
            },
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Container(
            width: SizeConfig.screenWidth * 0.85,
            //height: 50,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: Body.text,
              onSubmitted: (value) async {},
              onChanged: (value) {
                if (value == '') {
                  Body.newReview = '';
                } else {
                  Body.newReview = value;
                }
                setState(() {});
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Type Your Review".tr,
                prefixIcon: const Icon(Icons.chat),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(0),
                  vertical: getProportionateScreenWidth(12),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: (Body.newReview != '')
                    ? IconButton(
                        onPressed: () async {
                          // CommentController con = Get.put(CommentController());
                          // await con.SendComment(
                          //     Body.newReview); // add Body.newStars as parameter
                          // EasyLoading.show(status: 'loading...'.tr);
                          // Body.text.clear();
                          // Body.newReview = '';
                          // Body.newStars = 3;
                          // setState(() {});
                          // EasyLoading.showSuccess(
                          //   'Done'.tr,
                          //   duration: const Duration(seconds: 1),
                          // );
                          ReviewController controller =
                              Get.put(ReviewController());
                          ReviewController.numStar = Body.newStars;
                          ReviewController.review = Body.newReview;
                          controller.addReview(widget.product.id);
                          Body.text.clear();
                          Body.newReview = '';
                          Body.newStars = 3;
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      )
                    : const Icon(
                        Icons.send,
                        color: Color(0xFFDBDEE4),
                      ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Text(
            "All Reviews".tr,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18),
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          Flexible(
            child: GridView.count(
              childAspectRatio: 6,
              scrollDirection: Axis.vertical,
              crossAxisCount: 1,
              children: [
                ...List.generate(
                  widget.reviews.length,
                  (index) => ReviewCard(
                    stars: widget.reviews[index].numStar,
                    review: widget.reviews[index].review,
                    //name: CommentController.names[index],
                    //image: CommentController.images[index],
                    press: () {
                      // when i click on the review i go to the user who make this review
                      UserController controller = Get.put(UserController());
                      controller.getUserAccount(
                          ConstServer.showUserById, widget.reviews[index].id!);
                      //setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
