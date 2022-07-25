import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.fromLTRB(
          0,
          getProportionateScreenWidth(15),
          getProportionateScreenWidth(0),
          getProportionateScreenWidth(15),
        ),
      ),
      onPressed: () {},
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(20),
      ),
    );
  }
}
