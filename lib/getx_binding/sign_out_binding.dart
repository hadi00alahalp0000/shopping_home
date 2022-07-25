import 'package:get/get.dart';
import 'package:shopping_home/controllers/sign_out_controller.dart';

class SignOutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SignOutController>(SignOutController());
  }
}
