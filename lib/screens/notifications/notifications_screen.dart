import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shopping_home/size_config.dart';

import 'components/body.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNotificationAppbar(),
      body: Body(),
    );
  }

  AppBar buildNotificationAppbar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(
            "Your Notifications".tr,
            style: const TextStyle(color: Colors.black),
          ),
          TextButton(
            onPressed: () => {
              // method to clear all notification
            },
            child: Text(
              "Clear All".tr,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          )
        ],
      ),
    );
  }
}
