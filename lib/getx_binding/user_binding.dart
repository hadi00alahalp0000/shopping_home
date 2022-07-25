import 'package:get/get.dart';
import 'package:shopping_home/controllers/user_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>((UserController()));
  }
}
