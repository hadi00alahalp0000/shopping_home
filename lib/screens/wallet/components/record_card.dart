import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:shopping_home/constants.dart';

import '../../../size_config.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    Key? key,
    required this.press,
    required this.balance,
    required this.date,
  }) : super(key: key);
  final GestureTapCallback press;
  final int balance;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(5),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 65,
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(17)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SvgPicture.asset("assets/icons/Bill Icon.svg")),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"Balance :".tr}               \$$balance",
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  Text(
                    "${"Date :".tr}${DateFormat('yyyy/MM/dd: HH:mm').format(date)}",
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
