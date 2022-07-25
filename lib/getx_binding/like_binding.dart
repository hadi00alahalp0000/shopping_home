import 'package:get/get.dart';
import 'package:shopping_home/controllers/like_controller.dart';

class LikeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LikeController>(LikeController());
  }
}
