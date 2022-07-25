import 'package:get/get.dart';
import 'package:shopping_home/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>((SplashController()));
  }
}
