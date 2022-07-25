import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_home/components/menu_button.dart';
import 'package:shopping_home/controllers/record_controller.dart';
import 'package:shopping_home/controllers/wallet_controller.dart';
import 'package:shopping_home/models/my_wallet.dart';

import '../../../size_config.dart';
import 'wallet_credit_card.dart';

class Body extends StatefulWidget {
  static MyWallet wallet = WalletController.wallet;
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),
              Column(
                children: [
                  Text(
                    "My Wallet".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  WalletCreditCard(
                    wallet: Body.wallet,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  MenuButton(
                    text: "Pay Records".tr,
                    icon: "assets/icons/Bill Icon.svg",
                    press: () {
                      RecordController controller = Get.put(RecordController());
                      controller.getMyPayRecords();
                    },
                  ),
                  MenuButton(
                    text: "Take Records".tr,
                    icon: "assets/icons/Cash.svg",
                    press: () {
                      RecordController controller = Get.put(RecordController());
                      controller.getMyTakeRecords();
                    },
                  ),
                  MenuButton(
                    text: "Give Records".tr,
                    icon: "assets/icons/Gift Icon.svg",
                    press: () {
                      RecordController controller = Get.put(RecordController());
                      controller.getMyGiveRecords();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
