import 'package:get/get.dart';
import 'package:shopping_home/controllers/edit_review_controller.dart';

class EditReviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EditReviewController>(EditReviewController());
  }
}
