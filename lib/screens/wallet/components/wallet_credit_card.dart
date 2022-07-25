import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/models/my_wallet.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class WalletCreditCard extends StatelessWidget {
  final MyWallet wallet;

  const WalletCreditCard({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      height: getProportionateScreenHeight(250),
      width: getProportionateScreenWidth(350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: kPrimaryGradientColor,
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.6),
            spreadRadius: 6,
            blurRadius: 5,
            offset: const Offset(-3.5, 3.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Shopping Home".tr,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(175)),
              Image.asset(
                "assets/images/shopping_home_logo.png",
                width: 25,
                height: 25,
                color: Colors.deepOrange,
              ),
            ],
          ),
          Text(
            "Current Balance".tr,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            "\$ " '$wallet.balance',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          const Center(
            child: Text(
              "5620  ****  ****  ****  8254",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/sim_card.png",
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
