import 'package:flutter/material.dart';

import '../../../size_config.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);
  final GestureTapCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        children: [
          SizedBox(width: getProportionateScreenWidth(8)),
          SizedBox(
            height: 85,
            width: 108,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                    "assets/images/notification-bell-icon-removebg-preview.png"),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          )
        ],
      ),
    );
  }
}
