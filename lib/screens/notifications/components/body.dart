import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_home/controllers/my_notification_controller.dart';
import 'package:shopping_home/models/notification.dart';

import '../../../size_config.dart';
import 'notification_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  List<MyNotification> myNotifications =
      ShowMyNotificationController.myNotifications;
  ShowMyNotificationController controller = ShowMyNotificationController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: ListView.builder(
        itemCount: myNotifications.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Dismissible(
            key: Key(index.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              await controller.deleteMyNotification(myNotifications[index].id);
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: NotificationCard(
              text: myNotifications[index].title, // notification body
              press: () => {}, // go to what the notification about,
            ),
          ),
        ),
      ),
    );
  }
}
