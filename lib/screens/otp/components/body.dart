import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shopping_home/controllers/sign_up_controller.dart';
import 'package:shopping_home/screens/otp/components/otp_form.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Center(
                  widthFactor: getProportionateScreenWidth(4.5),
                  child: Text(
                    "OTP Verification".tr,
                    style: headingStyle,
                  ),
                ),
                Text(
                  "We sent your code to your email".tr,
                  textAlign: TextAlign.center,
                ),
                buildTimer(),
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                const OtpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                GestureDetector(
                  onTap: () {
                    //resend otp
                    SignUpController controller = Get.put(SignUpController());
                    controller.checkotb();
                  },
                  child: Text(
                    "Resend OTP Code".tr,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in".tr),
        TweenAnimationBuilder(
          tween: IntTween(begin: 60, end: 0),
          duration: const Duration(seconds: 60),
          builder: (context, value, child) => Text(
            "00:$value",
            style: const TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}
