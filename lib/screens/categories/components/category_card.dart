import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.text,
    required this.press,
    required this.catIndex,
  }) : super(key: key);
  final int catIndex;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: getProportionateScreenWidth(100),
        child: AspectRatio(
          aspectRatio: 1.02,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: kPrimaryColor,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: const Color(0xFFF5F6F9),
            ),
            onPressed: press,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Category.svg",
                      color: kPrimaryColor,
                      width: 22,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        text,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Flexible(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    children: [
                      ...List.generate(
                        4,
                        (index) => Image.asset(
                          "assets/images/product.png", //controller.categories[catIndex].images[index]
                          width: getProportionateScreenWidth(10),
                          height: getProportionateScreenHeight(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
