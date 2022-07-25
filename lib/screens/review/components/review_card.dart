import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_home/models/user_information.dart';

import '../../../size_config.dart';
import '../../../components/bubble.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    this.aspectRetion = 1.02,
    required this.stars,
    required this.review,
    required this.press,
    // this.width = 100,
    //required this.image,
    //required this.name,
  }) : super(key: key);

  final dynamic aspectRetion;
  final dynamic stars;
  final dynamic review;
  final GestureTapCallback press;
  //final String name;
  //final Image image;

  @override
  Widget build(BuildContext context) {
    if (UserInformation.languge == 'true') {
      return Stack(
        children: [
          const Positioned(
            left: 23,
            bottom: 9,
            child: SizedBox(
              height: 38,
              width: 38,
              // child: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(55),
              //     image: DecorationImage(
              //       fit: BoxFit.fill,
              //       image: image.image,
              //     ),
              //   ),
              // ),
            ),
          ),
          Positioned(
            left: 80,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                  width: 100,
                  // child: Text(
                  //   name,
                  //   style: const TextStyle(
                  //     color: Colors.blueAccent,
                  //     fontWeight: FontWeight.w800,
                  //     fontSize: 9.0,
                  //   ),
                  // ),
                ),
                const SizedBox(width: 25),
                Text(
                  stars,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5),
                SvgPicture.asset("assets/icons/Star Icon.svg"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(65)),
            child: GestureDetector(
              onTap: press,
              child: SizedBox(
                child: BubbleMessage(
                  painter: BubblePainter(),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 50,
                      // minWidth: 50.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 10.0),
                    child: const Text(
                      "", //revu.review
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          const Positioned(
            right: 0,
            bottom: 9,
            child: SizedBox(
              height: 38,
              width: 38,
              // child: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(55),
              //     image: DecorationImage(
              //       fit: BoxFit.fill,
              //       image: image.image,
              //     ),
              //   ),
              // ),
            ),
          ),
          Positioned(
            left: 200,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/icons/Star Icon.svg"),
                const SizedBox(width: 5),
                Text(
                  stars,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 25),
                const SizedBox(
                  height: 20,
                  width: 100,
                  // child: Text(
                  //   name,
                  //   style: const TextStyle(
                  //     color: Colors.blueAccent,
                  //     fontWeight: FontWeight.w800,
                  //     fontSize: 10.0,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(40),
            ),
            child: GestureDetector(
              onTap: press,
              child: SizedBox(
                child: BubbleMessage(
                  painter: BubblePainterarabic(),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 50,
                      // minWidth: 50.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: const Text(
                      "", //revu.review
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
