import 'package:get/get.dart';
import 'package:shopping_home/controllers/my_notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ShowMyNotificationController>(ShowMyNotificationController());
  }
}