import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/components/rounded_icon_btn.dart';
import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedIconBtn(
                iconData: Icons.arrow_back_ios_new_rounded,
                press: () {
                  Navigator.pop(context);
                }),
                const Spacer(),
            Center(
              child: Text(
                "Edit Product Details".tr,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
