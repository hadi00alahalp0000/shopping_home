import 'package:get/get.dart';
import 'package:shopping_home/controllers/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(SignInController());
  }
}
