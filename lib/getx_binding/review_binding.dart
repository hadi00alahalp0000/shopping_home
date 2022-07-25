import 'package:get/get.dart';
import 'package:shopping_home/controllers/review_controller.dart';

class ReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ReviewController>(ReviewController());
  }
}
